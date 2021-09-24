class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy]

  def create
        user = User.find_or_create_by(uid: auth['uid'], provider: auth['provider']) do |u|
          u.providerImage = auth['info']['image']
          u.name = auth['info']['name']
          u.email = auth['info']['email']
        end

      if user
        #save image whenever its a login - since they can expire
        user.providerImage = auth['info']['Providerimage']
        token = encode_token(user_id: user.id)

        # render json: { token: token }

        redirect_to('http://localhost:3001/#/' + "?token=#{token}")
      else
        render json: { error: 'failed to create/find user' }, status: :not_acceptable
      end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
    def set_user
    @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :provider, :uid)
    end

    def auth
      request.env['omniauth.auth']
    end 
end
