class AddBackgroundColorToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :background_color, :string
  end
end
