class Event < ActiveRecord::Base
  attr_accessible :closed_at, :description, :service_ids, :status_id
  
  has_many :event_services
  has_many :services, :through => :event_services
  
  def current?
    return true if closed_at == nil
  end
  
  def self.outages
    where(:status_id => Status.find_by_value("Outage"))
  end
  
  def self.current
    where(:closed_at => nil)
  end
  
  def close
    self.closed_at = Time.zone.now
  end
  
  def closed?
    return true unless closed_at == nil
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
