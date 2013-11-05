class Network < ActiveRecord::Base
  attr_accessible :name
  
  has_many :ip_addresses, :dependent => :destroy
end
