class CreateEventServices < ActiveRecord::Migration
  def change
    create_table :event_services do |t|
      t.integer :event_id
      t.string :service_id

      t.timestamps
    end
  end
end
