class RemoveStartedAtFromProblems < ActiveRecord::Migration
  def up
    remove_column :problems, :started_at
  end

  def down
    add_column :problems, :started_at, :datetime
  end
end
