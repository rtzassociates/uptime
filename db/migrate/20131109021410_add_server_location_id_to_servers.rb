class AddServerLocationIdToServers < ActiveRecord::Migration
  def change
    add_column :servers, :server_location_id, :integer
  end
end
