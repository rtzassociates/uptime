class AddIncludeInCalcToStatuses < ActiveRecord::Migration
  def change
    add_column :statuses, :include_in_calc, :boolean, :null => false, :default => false
  end
end
