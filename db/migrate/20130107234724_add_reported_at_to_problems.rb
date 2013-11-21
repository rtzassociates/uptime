class AddReportedAtToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :reported_at, :datetime
  end
end
