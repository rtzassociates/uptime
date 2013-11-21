class RenameServiceIdColumnToSiteId < ActiveRecord::Migration
  def up
    rename_column :event_sites, :service_id, :site_id
  end

  def down
    rename_column :event_sites, :site_id, :service_id
  end
end
