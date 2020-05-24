class CreateSecrets < ActiveRecord::Migration[6.0]
  def change
    create_table :secrets do |t|
      t.string :weight
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
