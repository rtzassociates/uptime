class DropColumnForegroundColorFromStatuses < ActiveRecord::Migration
  def up
    remove_column :statuses, :foreground_color
  end

  def down
  end
end
