class TablesController < ApplicationController
    before_action :set_restaurant, only: [:create, :destroy]

    def create
       byebug
        @restaurant.tables.create(open: true, seating: Date.today)
    
        render json: @restaurant.tables
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_restaurant
      @restaurant = Restaurant.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def table_params
      params.require(:table).permit(:restaurant_id, :seating, :open)
    end
end
