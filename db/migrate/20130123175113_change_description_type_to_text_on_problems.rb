class ChangeDescriptionTypeToTextOnProblems < ActiveRecord::Migration
  def up
    change_column :problems, :description, :text
  end

  def down
    change_column :problems, :description, :string
  end
end
