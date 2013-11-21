class RemoveUserIdAndStartTimeFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :user_id
    remove_column :events, :start_time
  end

  def down
    add_column :events, :user_id, :integer
    add_column :events, :user_id, :integer
  end
end
