module Api
  module V1
    class MediaController < ApplicationController
      respond_to :xml, :json

      def get_packages_for_device
        @errors = []
        begin
          if params[:device_id].present?
            @packages = Schedule.where("device_id = ?", params[:device_id])
            if @packages.empty?
              @errors << {:error_no => 1, :message => "no packages found for device_id : #{params[:device_id]}"}
            end
          else
            @errors << {:error_no => 2, :message => "no device id provided"}
          end
        rescue Exception => e
          @errors << {:error_no => 99, :message => e.message}
        end
        respond_to do |format|
          if @errors.empty?
            format.json {render :json => @packages}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end
      end

      def get_package
        @errors = []
        begin
          if params[:package_id].present?
            @package = Package.find(params[:package_id])
            if @package.blank?
              @errors << {:error_no => 1, :message => "no packages found for package_id : #{params[:package_id]}"}
            end
          else
            @errors << {:error_no => 2, :message => "no package id provided"}
          end

        rescue Exception => e
          @errors << {:error_no => 99, :message => e.message}
        end
        respond_to do |format|
          if @errors.empty?
            format.json {render :json => @package}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end
      end


    end
  end
end