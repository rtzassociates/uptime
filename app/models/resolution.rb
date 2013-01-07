class Resolution < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description
  
  belongs_to :event
  belongs_to :user
end
