class AddUserIdToTasks < ActiveRecord::Migration[6.0]
  def up
    execute 'DELETE FROM tasks;'
    add_reference :tasks, :user, foreign_key: true 
  end
  def down
    remove_reference :tasks, :user, foreign_key: true 
  end
end
