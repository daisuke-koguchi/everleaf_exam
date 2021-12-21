class CreateLabelTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :label_tasks do |t|
      t.references :label, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
