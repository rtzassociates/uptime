class Interface < ActiveRecord::Base
  attr_accessible :name
  
  has_many :ip_addresses
end