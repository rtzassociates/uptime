class CreateServers < ActiveRecord::Migration
  def change
    create_table :servers do |t|
      t.string :name
      t.text :description
      t.datetime :deployed_at

      t.timestamps
    end
  end
end
