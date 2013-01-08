class Event < ActiveRecord::Base
  attr_accessible :service_ids, :problem_attributes, :status_id
  
  has_many :event_services, :dependent => :destroy
  has_many :services, :through => :event_services

  belongs_to :status
  
  has_one :problem
  accepts_nested_attributes_for :problem
  
  has_one :resolution
  
  def resolved_at
    resolution.resolved_at || nil
  end
  
  def current?
    return true if resolved_at == nil
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
  
  def resolved?
    return true if resolution
  end
  
  def duration
    if self.current?
      Time.zone.now - problem.start_time
    else
      resolution.resolved_at - problem.start_time
    end
  end
  
end
