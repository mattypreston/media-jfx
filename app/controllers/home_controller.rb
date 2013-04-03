class HomeController < ApplicationController
  def index
    @users = User.all
    sites = Site.all.count rescue 0
    devices = Device.all.count rescue 0
    packages = Package.all.count rescue 0
    assets = Asset.all.count rescue 0
    @stats = Hash.new
    @stats[:sites] = sites
    @stats[:devices] = devices
    @stats[:packages] = packages
    @stats[:assets] = assets


  end
end
