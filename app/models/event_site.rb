class EventSite < ActiveRecord::Base
  attr_accessible :event_id, :site_id
  
  belongs_to :event
  belongs_to :site
end
