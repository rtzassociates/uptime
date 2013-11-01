class DropDatabaseServers < ActiveRecord::Migration
  def up
    drop_table :database_servers
  end

  def down
    create_table "database_servers", :force => true do |t|
      t.string   "name"
      t.text     "description"
      t.datetime "deployed_at"
      t.datetime "created_at",  :null => false
      t.datetime "updated_at",  :null => false
    end
  end
end
