class CreateSiteServers < ActiveRecord::Migration
  def change
    create_table :site_servers do |t|
      t.integer :site_id
      t.integer :server_id

      t.timestamps
    end
  end
end
