class CreateServerLocations < ActiveRecord::Migration
  def change
    create_table :server_locations do |t|
      t.string :name
      t.text :notes

      t.timestamps
    end
  end
end
