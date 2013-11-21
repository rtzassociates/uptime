class DropTasksTable < ActiveRecord::Migration
  def up
    drop_table :tasks
    drop_table :task_notes
    drop_table :completions
  end

  def down
  end
end
