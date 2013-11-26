class ServerRole < ActiveRecord::Base
  attr_accessible :role

  has_many :generic_servers
end
