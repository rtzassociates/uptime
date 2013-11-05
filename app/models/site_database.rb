class SiteDatabase < ActiveRecord::Base
  attr_accessible :database_id, :site_id
  
  belongs_to :database, touch: true
  belongs_to :site, touch: true
  
end
