class DropColumnTextColorFromStatuses < ActiveRecord::Migration
  def up
    remove_column :statuses, :text_color
  end

  def down
  end
end
