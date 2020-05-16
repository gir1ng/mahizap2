class CreateMealRecords < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_records do |t|
      t.string :meal_content
      t.integer :total_calorie
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
