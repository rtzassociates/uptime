class Status < ActiveRecord::Base
  attr_accessible :value
  
  has_many :services
  has_many :events
end