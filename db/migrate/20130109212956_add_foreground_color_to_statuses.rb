class AddForegroundColorToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :foreground_color, :string
  end
end
