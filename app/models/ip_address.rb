class IpAddress < ActiveRecord::Base
  attr_accessible :network_id, :value
  
  belongs_to :network
  belongs_to :server
  
  ValidIpAddressRegex = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/
  validates_format_of :value, :with => ValidIpAddressRegex
  validates :value, :presence => true, :uniqueness => true
  validates :network_id, :presence => true
end
