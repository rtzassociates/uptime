class CreateWindowsClients < ActiveRecord::Migration
  def change
    create_table :windows_clients do |t|
      t.string :name

      t.timestamps
    end
  end
end
