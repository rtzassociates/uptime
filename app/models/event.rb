class Event < ActiveRecord::Base
  attr_accessible :closed_at, :description, :service_id, :status_id
  
  has_many :event_services
  has_many :services, :through => :event_services
  
  def is_active?
    return true if closed_at == nil
  end
  
  def self.outages
    where(:status_id => Status.find_by_value("down"))
  end
  
  def self.recoveries
    where(:status_id => Status.find_by_value("up"))
  end
  
  def self.active
    where(:closed_at => nil)
  end
  
  def close
    self.closed_at = Time.zone.now
  end
  
  def status_string
    Status.find(status_id).value
  end
  
  def duration
    if self.is_active?
      Time.zone.now - created_at
    else
      closed_at - created_at
    end
  end
end
