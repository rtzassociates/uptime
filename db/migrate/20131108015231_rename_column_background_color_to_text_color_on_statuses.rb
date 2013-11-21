class RenameColumnBackgroundColorToTextColorOnStatuses < ActiveRecord::Migration
  def up
    rename_column :statuses, :background_color, :text_color
  end

  def down
  end
end
