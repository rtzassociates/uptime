class SiteDatabase < ActiveRecord::Base
  attr_accessible :database_id, :site_id
  
  belongs_to :database, touch: true
  belongs_to :site, touch: true
  
  before_save :touch_application_server
  
  def touch_application_server
    self.site.application_servers.each do |application_server|
      application_server.touch
    end
  end
  
end
