class AddSugarToFoods < ActiveRecord::Migration[6.0]
  def change
    add_column :foods, :sugar, :float, default: 0
  end
end
