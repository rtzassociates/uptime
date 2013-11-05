class SiteServer < ActiveRecord::Base
  attr_accessible :server_id, :site_id
  
  belongs_to :server, touch: true
  belongs_to :site, touch: true
  
end
