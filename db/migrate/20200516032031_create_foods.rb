class CreateFoods < ActiveRecord::Migration[6.0]
  def change
    create_table :foods do |t|
      t.string :food_name
      t.string :search_name
      t.string :quantifier
      t.integer :calorie

      t.timestamps
    end
    add_index :foods, [:food_name], unique: true
  end
end
