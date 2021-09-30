class SessionsController < ApplicationController
    def authenticate_google
      redirect_to '/auth/google_oauth2'
    end

    def onesignal_auth_hash
        hash= OpenSSL::HMAC.hexdigest('sha256', ENV['ONESIGNAL_API_KEY'], "#{current_user.id}")
        render json: {hash: hash}
    end
end 
  