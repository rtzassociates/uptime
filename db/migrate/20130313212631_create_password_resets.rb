class CreatePasswordResets < ActiveRecord::Migration
  def change
    create_table :password_resets do |t|
      t.string :password_reset_token
      t.datetime :expires_at
      t.integer :user_id

      t.timestamps
    end
  end
end
