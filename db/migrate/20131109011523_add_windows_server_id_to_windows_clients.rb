class AddWindowsServerIdToWindowsClients < ActiveRecord::Migration
  def change
    add_column :windows_clients, :windows_server_id, :integer
  end
end
