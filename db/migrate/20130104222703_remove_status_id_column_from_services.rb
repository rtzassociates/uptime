class RemoveStatusIdColumnFromServices < ActiveRecord::Migration
  def up
    remove_column :services, :status_id
  end

  def down
    add_column :services, :status_id, :integer
  end
end
