class AddServiceIdToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :service_id, :integer
  end
end
