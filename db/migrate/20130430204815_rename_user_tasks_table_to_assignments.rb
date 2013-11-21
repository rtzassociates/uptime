class RenameUserTasksTableToAssignments < ActiveRecord::Migration
  def change
    rename_table :user_tasks, :assignments
  end
end
