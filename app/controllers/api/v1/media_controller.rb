module Api
  module V1
    class MediaController < ApplicationController
      respond_to :xml, :json

      def get_fxml
        @errors = []
        begin
          if params[:device_id].present?
            @schedules = Schedule.where("device_id = ?", params[:device_id])
            if @schedules.empty?
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
            format.json {render :json => @schedules, :include => :package}
          else
            format.json {render :json => {:errors => @errors}}
          end
        end
      end

      def get_package
        begin

          if params[:device_id].present?
            if params[:date_time].present?

            else
              #Assume current date

            end
          else
            # Error
          end

        rescue Exception => e

        end

      end

      def get_asset

      end

    end
  end
end