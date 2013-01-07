class Event < ActiveRecord::Base
  attr_accessible :description, :service_ids, :status_id, :user_id
  
  has_many :event_services, :dependent => :destroy
  has_many :services, :through => :event_services
  
  belongs_to :user
  has_one :resolution
  
  def closed_at
    resolution.created_at || nil
  end
  
  def current?
    return true if closed_at == nil
  end
  
  def self.outages
    where(:status_id => Status.find_by_value("outage"))
  end
  
  def self.current
    current_events = []
    all.each do |event|
      if event.resolution.nil?
        current_events << event
      end
    end
    current_events
  end
  
  def closed?
    return true if resolution
  end
  
  def status
    Status.find(status_id).value
  end
  
  def duration
    if self.current?
      Time.zone.now - created_at
    else
      closed_at - created_at
    end
  end
end
