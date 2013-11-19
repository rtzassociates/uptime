class AddSiteEnvironmentIdToSite < ActiveRecord::Migration
  def change
    add_column :sites, :site_environment_id, :integer
  end
end
