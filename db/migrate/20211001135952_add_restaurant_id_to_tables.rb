class AddRestaurantIdToTables < ActiveRecord::Migration[6.0]
  def change
    add_reference :tables, :restaurant, index: true
  end
end
