class LikesController < ApplicationController
    before_action :set_restaurant, only: [:create, :destroy]

    def index
        render json: current_user.likes
    end

    def create
        @restaurant.likes.create(user_id: current_user.id)
    
        render json: current_user.likes
    end

    def destroy
        Like.find_by(restaurant_id: @restaurant.id, user_id: current_user.id).destroy
    
        render json: current_user.likes
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def like_params
      params.require(:like).permit(:user_id, restaurant_id)
    end

    def already_liked?(rest_id)
        Like.where(user_id: current_user.id, restaurant_id:
        rest_id).exists?
    end
end
