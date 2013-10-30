class Package < ActiveRecord::Base
  has_many :schedules
  has_many :assets
  attr_accessible :name, :fxml
  include Rails.application.routes.url_helpers

  def as_json(options)
    hash = super(options.merge({:only => [:id, :name, :fxml]}).merge({:include => :assets}))
    hash[:assets].each do |asset|
      asset_url = "#{MEDIA_JFX_CONFIG['url_prefix']}#{asset['asset_file']['url']}" if asset['asset_file']['url'].present?
      asset['asset_file']['url'] = asset_url if asset_url.present?
    end
    hash
  end

  def remove_all_previous_assets
    self.assets.each do |asset|
      File.exists?("#{asset.directory}/#{asset.name}") if asset.directory.present?
      File.delete("#{asset.directory}/#{asset.name}")
      Dir.delete(asset.directory)
      Asset.delete(asset.id)
    end unless self.assets.empty?
  end

  def create_associated_assets(package_id, assets, uploaded_over_api)
    assets.each do |asset|
      @asset = Asset.new()
      name = asset[:file_name]
      media_type = asset[:file_type]
      media_type = 'mov' if /quicktime/.match(media_type.downcase)
      @asset.package_id = package_id
      @asset.name = name
      @asset.media_type = media_type
      @asset.uploaded_over_api = uploaded_over_api
      @asset.save!
      @asset.save_to_disk(name, asset[:asset_file])
      @asset.save!
    end

  end

end
