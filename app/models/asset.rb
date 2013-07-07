require 'base64'

class Asset < ActiveRecord::Base
  belongs_to :package
  attr_accessible :package_id, :name, :asset_file, :media_type, :uploaded_over_api, :directory
  mount_uploader :asset_file, AssetUploader

  def convert_to_file(file_to_convert)

    encoded_data = Base64.decode64(file_to_convert)
    encoded_data

  end

end
