class WindowsClient < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :windows_server
end
