class ApplicationServer < Server
  attr_accessible :site_ids
  
  has_many :site_servers, :dependent => :destroy, :foreign_key => "server_id"
  has_many :sites, :through => :site_servers
   
  def site_urls
    sites.joins(:urls).pluck("urls.name").uniq
  end
end