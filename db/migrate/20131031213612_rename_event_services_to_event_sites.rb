class RenameEventServicesToEventSites < ActiveRecord::Migration
  def up
    rename_table :event_services, :event_sites
  end

  def down
    rename_table :event_sites, :event_services
  end
end
