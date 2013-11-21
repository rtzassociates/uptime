class CreateIpAddresses < ActiveRecord::Migration
  def change
    create_table :ip_addresses do |t|
      t.integer :interface_id
      t.string :value

      t.timestamps
    end
  end
end
