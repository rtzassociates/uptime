class WindowsServer < Server
  attr_accessible :windows_clients_attributes
  
  has_many :windows_clients, :dependent => :destroy
  accepts_nested_attributes_for :windows_clients, allow_destroy: true
  
  def self.public_servers
    WindowsServer.joins(:ip_addresses => :network).where("networks.name" => "public")
  end 
end