class CreateServerRoles < ActiveRecord::Migration
  def change
    create_table :server_roles do |t|
      t.string :role

      t.timestamps
    end
  end
end
