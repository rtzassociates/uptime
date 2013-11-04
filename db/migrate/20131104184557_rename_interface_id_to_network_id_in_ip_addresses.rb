class RenameInterfaceIdToNetworkIdInIpAddresses < ActiveRecord::Migration
  def up
    rename_column :ip_addresses, :interface_id, :network_id
  end

  def down
    rename_column :ip_addresses, :network_id, :interface_id
  end
end
