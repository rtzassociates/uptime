class AddPublicIpAddressToServers < ActiveRecord::Migration
  def change
    add_column :servers, :public_ip_address, :string
  end
end
