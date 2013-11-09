class CreateServerTypes < ActiveRecord::Migration
  def change
    create_table :server_types do |t|
      t.text :value

      t.timestamps
    end
  end
end
