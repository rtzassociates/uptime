class ServerType < ActiveRecord::Base
  attr_accessible :value
  
  has_many :servers
end
