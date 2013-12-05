class WindowsServer < Server
  attr_accessible :windows_clients_attributes
  
  has_many :windows_clients, :dependent => :destroy
  accepts_nested_attributes_for :windows_clients, allow_destroy: true
  
end
