class ChangeDescriptionTypeToTextOnResolutions < ActiveRecord::Migration
  def up
    change_column :resolutions, :description, :text
  end

  def down
    change_column :resolutions, :description, :string
  end
end
