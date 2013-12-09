class AddCheckStringToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :check_string, :string
  end
end
