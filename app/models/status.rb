class Status < ActiveRecord::Base
  attr_accessible :value
  
  has_many :events
  
  def value
    read_attribute(:value).capitalize
  end
end