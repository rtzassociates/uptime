class CreateSiteEnvironments < ActiveRecord::Migration
  def change
    create_table :site_environments do |t|
      t.string :name

      t.timestamps
    end
  end
end
