class EventService < ActiveRecord::Base
  attr_accessible :event_id, :service_id
  
  belongs_to :event
  belongs_to :service
end
