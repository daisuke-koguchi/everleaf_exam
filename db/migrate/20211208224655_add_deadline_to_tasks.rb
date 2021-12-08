class AddDeadlineToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :datetime, default: -> {'NOW()'}, null: false
  end
end
