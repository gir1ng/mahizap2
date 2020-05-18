class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :todo
      t.string :not_todo
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
