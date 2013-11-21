class AddDescriptionToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :description, :string
  end
end
