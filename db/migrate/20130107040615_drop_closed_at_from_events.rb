class DropClosedAtFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :closed_at
  end

  def down
    add_column :events, :closed_at, :datetime
  end
  
end
