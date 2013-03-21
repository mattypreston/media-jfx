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

end
