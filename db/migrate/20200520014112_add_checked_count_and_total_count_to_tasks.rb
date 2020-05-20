class AddCheckedCountAndTotalCountToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :checked_count, :integer, default: 0
    add_column :tasks, :total_count, :integer, default: 0
  end
end
