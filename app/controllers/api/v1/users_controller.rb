module Api
  module V1
    class UsersController < ApplicationController
      respond_to :xml, :json
      def get_users
        @users = User.all
        respond_to do |format|
          format.json {render :json => @users}
        end
      end
    end
  end
end