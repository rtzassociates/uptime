class RemoveServiceIdFromEvents < ActiveRecord::Migration
  def up
    remove_column :events, :service_id
  end

  def down
    add_column :events, :service_id, :integer
  end
end
