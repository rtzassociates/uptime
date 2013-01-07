class Event < ActiveRecord::Base
  attr_accessible :start_time_text, :description, :service_ids, :status_id, :user_id
  
  has_many :event_services, :dependent => :destroy
  has_many :services, :through => :event_services
  
  belongs_to :user
  has_one :resolution
  
  def start_time_text
    start_time.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def start_time_text=(time)
    self.start_time = Chronic.parse(time) if time.present?
  rescue ArgumentError
    self.start_time = nil
  end
  
  def services_affected_count
    services.count
  end
  
  def closed_at
    resolution.resolved_at || nil
  end
  
  def current?
    return true if closed_at == nil
  end
  
  def self.outages
    where(:status_id => Status.find_by_value("outage"))
  end
  
  def self.slowdowns
    where(:status_id => Status.find_by_value("slow"))
  end
  
  def self.errors
    where(:status_id => Status.find_by_value("error"))
  end
  
  def self.restarts
    where(:status_id => Status.find_by_value("restart"))
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
      Time.zone.now - start_time
    else
      closed_at - start_time
    end
  end
end
