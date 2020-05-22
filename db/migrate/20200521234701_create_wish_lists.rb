class CreateWishLists < ActiveRecord::Migration[6.0]
  def change
    create_table :wish_lists do |t|
      t.string :wish_content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
