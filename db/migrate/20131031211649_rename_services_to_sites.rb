class RenameServicesToSites < ActiveRecord::Migration
  def up
    rename_table :services, :sites
  end

  def down
    rename_table :sites, :services
  end
end
