class CreateTables < ActiveRecord::Migration[6.0]
  def change
    create_table :tables do |t|
      t.seating :date
      t.open :boolean

      t.timestamps
    end
  end
end
