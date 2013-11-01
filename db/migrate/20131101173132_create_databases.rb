class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
      t.string :name
      t.integer :server_id

      t.timestamps
    end
  end
end
