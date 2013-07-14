module Api
  module V1
    class AuthenticationController < ApplicationController
      respond_to :xml, :json

      def get_token
        @errors = []
        @token = nil
        @email = params[:email]
        @password = params[:password]
        if params.present?
          if @email.nil?
            @errors << {:error_no => 1, :message => "no email provided"}
          elsif @password.nil?
            @errors << {:error_no => 2, :message => "no password provided"}
          end
          @user = User.find_for_database_authentication(:email=>@email)
          @token = @user.authentication_token unless @user.nil?
          @authenticated = @user.valid_password?(@password) unless @user.nil?
          if @user.nil?
            @errors << {:error_no => 3, :message => "unable to authenticate this operator"}
          end
        end

        respond_to do |format|
          if @errors.empty?
            format.json {render :json => {:success => :success, :token => @token, :email => @email, :password => @authenticated}}
          else
            format.json {render :json => {:success => :auth_failed, :errors => @errors}}
          end
        end
      end

    end
  end
end