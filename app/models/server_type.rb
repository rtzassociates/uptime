class ServerType < ActiveRecord::Base
  attr_accessible :value
  
  belongs_to :server
end
