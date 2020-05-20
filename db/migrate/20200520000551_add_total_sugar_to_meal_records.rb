class AddTotalSugarToMealRecords < ActiveRecord::Migration[6.0]
  def change
    add_column :meal_records, :total_sugar, :integer, default: 0
  end
end
