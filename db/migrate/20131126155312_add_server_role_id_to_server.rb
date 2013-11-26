class AddServerRoleIdToServer < ActiveRecord::Migration
  def change
    add_column :servers, :server_role_id, :integer
  end
end
