class RenameSiteServersSiteApplicationServers < ActiveRecord::Migration
  def up
    rename_column :site_servers, :server_id, :application_server_id
    rename_table :site_servers, :site_application_servers
  end

  def down
    rename_table :site_application_servers, :site_servers
    rename_column :site_servers, :application_server_id, :server_id 
  end
end
