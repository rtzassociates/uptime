class ServerLocation < ActiveRecord::Base
  attr_accessible :name, :notes
  
  has_many :servers
end
