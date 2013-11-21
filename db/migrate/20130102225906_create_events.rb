class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :description
      t.integer :service_id
      t.integer :status_id
      t.datetime :closed_at

      t.timestamps
    end
  end
end
