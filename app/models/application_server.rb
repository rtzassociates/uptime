class ApplicationServer < Server
  attr_accessible :site_ids
  
  has_many :site_application_servers, :dependent => :destroy
  has_many :sites, :through => :site_application_servers
   
  def site_urls
    sites.joins(:urls).pluck("urls.name").uniq
  end
  
  def site_databases
    Database.where(:name => self.sites.joins(:databases).pluck("databases.name").uniq)
  end
  
  def site_database_servers
    DatabaseServer.where(:name => self.site_databases.joins(:database_server).pluck("servers.name").uniq)
  end
  
  def self.public_servers
    ApplicationServer.joins(:ip_addresses => :network).where("networks.name" => "public")
  end
  
end