class Asset < ActiveRecord::Base
  belongs_to :package
  attr_accessible :package_id, :name, :asset_file
  mount_uploader :asset_file, AssetUploader
end