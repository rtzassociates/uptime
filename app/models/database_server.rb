class DatabaseServer < Server
  attr_accessible :database_ids
  
  has_many :databases, :dependent => :destroy
  
  def self.public_servers
    DatabaseServer.joins(:ip_addresses => :network).where("networks.name" => "public")
  end
end
