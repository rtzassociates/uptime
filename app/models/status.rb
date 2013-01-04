class Status < ActiveRecord::Base
  attr_accessible :value
  
  has_many :events
end