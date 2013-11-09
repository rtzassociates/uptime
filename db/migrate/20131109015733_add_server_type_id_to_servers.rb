class AddServerTypeIdToServers < ActiveRecord::Migration
  def change
    add_column :servers, :server_type_id, :integer
  end
end
