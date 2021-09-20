class CreateRestaurants < ActiveRecord::Migration[6.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :city
      t.string :state
      t.string :phone_number
      t.string :address
      t.string :postal_code

      t.timestamps
    end
  end
end
