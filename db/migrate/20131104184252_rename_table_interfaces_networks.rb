class RenameTableInterfacesNetworks < ActiveRecord::Migration
  def change
    rename_table :interfaces, :networks
  end
end
