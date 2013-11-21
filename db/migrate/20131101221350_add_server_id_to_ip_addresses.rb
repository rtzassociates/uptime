class AddServerIdToIpAddresses < ActiveRecord::Migration
  def change
    add_column :ip_addresses, :server_id, :integer
  end
end
