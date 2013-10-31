class RenameServiceIdColumnToSiteIdSubscriptions < ActiveRecord::Migration
  def up
    rename_column :subscriptions, :service_id, :site_id
  end

  def down
    rename_column :subscriptions, :service_id, :site_id
  end
end
