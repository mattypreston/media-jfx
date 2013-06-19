module Api
  module V1
    class PingController < ApplicationController
      respond_to :xml, :json

      def device_ping

        #Ping every hour.

        if params[:device_id].present? and params[:package_id].present?
          #Record a ping in a new table
        end

      end
    end
  end
end
