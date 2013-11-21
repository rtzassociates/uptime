class AddTaskIdToTaskNotes < ActiveRecord::Migration
  def change
    add_column :task_notes, :task_id, :integer
  end
end
