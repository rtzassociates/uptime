class AddEventIdToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :event_id, :integer
  end
end
