class RenameServiceIdColumnToSiteIdUrls < ActiveRecord::Migration
  def up
    rename_column :urls, :service_id, :site_id
  end

  def down
    rename_column :urls, :site_id, :service_id
  end
end
