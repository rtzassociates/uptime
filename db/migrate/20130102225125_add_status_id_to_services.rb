class AddStatusIdToServices < ActiveRecord::Migration
  def change
    add_column :services, :status_id, :integer
  end
end
