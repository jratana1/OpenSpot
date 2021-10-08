class AddTimeToTables < ActiveRecord::Migration[6.0]
  def change
    add_column :tables, :time, :time
    add_column :tables, :seats, :integer
  end
end
