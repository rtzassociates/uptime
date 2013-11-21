class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.string :event_id
      t.string :user_id

      t.timestamps
    end
  end
end
