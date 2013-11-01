class CreateSiteDatabases < ActiveRecord::Migration
  def change
    create_table :site_databases do |t|
      t.integer :site_id
      t.integer :database_id

      t.timestamps
    end
  end
end
