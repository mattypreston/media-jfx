require 'base64'

class Asset < ActiveRecord::Base
  belongs_to :package
  attr_accessible :package_id, :name, :asset_file, :media_type, :uploaded_over_api, :directory
  mount_uploader :asset_file, AssetUploader

  def convert_to_file(file_to_convert)
    encoded_data = Base64.decode64(file_to_convert)
    encoded_data
  end


  def save_to_disk(name, asset_file)
    directory = "public/uploads/asset/asset_file/#{self.id}"
    Dir.mkdir(directory) unless File.exists?(directory)
    path = File.join(directory, name)
    file = self.convert_to_file(asset_file)
    File.open(path, "wb") { |f| f.write(file)}
    self.directory = directory
  end

end
