class SiteServer < ActiveRecord::Base
  attr_accessible :server_id, :site_id
  
  belongs_to :server
  belongs_to :site
  
end
