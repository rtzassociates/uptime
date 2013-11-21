class CreateDatabaseServers < ActiveRecord::Migration
  def change
    create_table :database_servers do |t|
      t.string :name
      t.text :description
      t.datetime :deployed_at

      t.timestamps
    end
  end
end
