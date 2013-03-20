class Package < ActiveRecord::Base
  has_many :schedules
  has_many :assets
  attr_accessible :name, :fxml
  include Rails.application.routes.url_helpers

  def as_json(options)
    #hash = super(options.merge!({:include => :assets}))
    hash = super(options.merge({:only => :id}).merge({:include => :assets}))
    hash[:assets].each do |asset|
      asset_url = "#{MEDIA_JFX_CONFIG['url_prefix']}#{asset['asset_file']['url']}" if asset['asset_file']['url'].present?
      puts asset_url
      asset['asset_file']['url'] = asset_url if asset_url.present?
    end



  end

end
