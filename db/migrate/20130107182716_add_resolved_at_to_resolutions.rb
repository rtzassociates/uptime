class AddResolvedAtToResolutions < ActiveRecord::Migration
  def change
    add_column :resolutions, :resolved_at, :datetime
  end
end
