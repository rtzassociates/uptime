class RenameServerIdToDatabaseServerIdInDatabases < ActiveRecord::Migration
  def up
    rename_column :databases, :server_id, :database_server_id
  end

  def down
    rename_column :databases, :database_server_id, :server_id
  end
end
