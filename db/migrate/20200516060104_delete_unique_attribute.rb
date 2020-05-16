class DeleteUniqueAttribute < ActiveRecord::Migration[6.0]
  def change
    remove_index :foods, :food_name
  end
end
