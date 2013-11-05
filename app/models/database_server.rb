class DatabaseServer < Server
  attr_accessible :database_ids
  
  has_many :databases, :dependent => :destroy
end
