class RenameServerIdToAppServerIdOnSiteServers < ActiveRecord::Migration
  def up
    rename_column :site_servers, :server_id, :app_server_id
  end

  def down
    rename_column :site_servers, :app_server_id, :server_id
  end
end
