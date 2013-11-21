class AddTypeToServers < ActiveRecord::Migration
  def change
    add_column :servers, :type, :string
  end
end
