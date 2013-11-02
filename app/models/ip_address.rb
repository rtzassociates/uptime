class IpAddress < ActiveRecord::Base
  attr_accessible :interface_id, :value
  
  belongs_to :interface
  belongs_to :server
  
  default_scope lambda { joins(:interface).order("interfaces.name") }
  
end
