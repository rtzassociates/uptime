class SiteApplicationServer < ActiveRecord::Base
  attr_accessible :application_server_id, :site_id
  
  belongs_to :application_server, touch: true
  belongs_to :site, touch: true
  
end