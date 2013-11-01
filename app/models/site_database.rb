class SiteDatabase < ActiveRecord::Base
  attr_accessible :database_id, :site_id
  
  belongs_to :database
  belongs_to :site
  
end
