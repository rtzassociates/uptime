class IpAddress < ActiveRecord::Base
  attr_accessible :network_id, :value
  
  belongs_to :network
  belongs_to :server
end
