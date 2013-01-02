class Status < ActiveRecord::Base
  attr_accessible :value
  
  has_many :services
end