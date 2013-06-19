module Api
  module V1
    class MediaController < ApplicationController
      respond_to :xml, :json

      def remove_force_flag_from_schedule
        @errors = []
        begin
          schedule_id = params[:schedule_id]
          schedule = Schedule.find(schedule_id)
          if schedule.present?
            schedule.force_flag = false
            schedule.save!
          end
          response = Hash.new()
          response[:success] = true
          response[:package_id] = schedule_id
          response[:message] = "Force flag removed"
        rescue Exception => e
          @errors << {:error_no => 99, :message => e.message}
        end
        respond_to do |format|
          if @errors.empty?
            format.json {render :json => response}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end
      end

      def force_schedule_to_be_current
        @errors = []
        begin
          schedule_id = params[:schedule_id]
          schedules = Schedule.find_all_by_force_flag(true)
          schedules.each do |schedule|
            schedule.force_flag = false
            schedule.save!
          end
          schedule = Schedule.find(schedule_id)
          if schedule.present?
            schedule.force_flag = true
            schedule.save!
          end
          response = Hash.new()
          response[:success] = true
          response[:package_id] = schedule_id
          response[:message] = "Force flag added"
        rescue Exception => e
          @errors << {:error_no => 99, :message => e.message}
        end
        respond_to do |format|
          if @errors.empty?
            format.json {render :json => response}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end
      end

      def get_packages_for_device
        @errors = []
        begin
          if params[:device_id].present?

            #First check to see if we have any with the force flag on.
            @packages = Schedule.find_all_by_force_flag(true)

            if @packages.empty?
              @packages = Schedule.where("device_id = ? and start_date_time < ?", params[:device_id], Date.today).
                                        order('start_date_time DESC')
            end

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
            format.json {render :json => @packages.first}
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

      def add_asset_to_package
        @errors = []

        begin
          assets = params[:assets]
          assets.each do |asset|
            @asset = Asset.new()
            file = asset[:asset_file]
            #media_type = file.split('/')[1].split(':')[0]
            #media_type = 'mov' if /quicktime/.match(media_type.downcase)
            @asset.package_id = params[:package_id]
            @asset.asset_file = file.present? ? file : nil
            #@asset.media_type = media_type
            @asset.save!
          end
          puts "Image uploaded"
        rescue Exception => e
          @errors << {:error_no => 99, :message => e.message}
        end
        respond_to do |format|
          if @errors.empty?
            format.json {render :json => {:response => :success}}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end


      end


    end
  end
end