class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.date :seating
      t.boolean :open

      t.timestamps
    end
  end
end
