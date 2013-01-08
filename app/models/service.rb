class Service < ActiveRecord::Base
  attr_accessible :name
  
  has_many :event_services
  has_many :events, :through => :event_services
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  def current_event
    events.current.first
  end
  
  def total_downtime
    events.outages.map { |e| e.duration }.sum
  end
  
  def lifespan_in_seconds
    Time.zone.now.to_i - created_at.to_i
  end
  
  def uptime_in_seconds
    lifespan_in_seconds - total_downtime
  end
  
  def uptime
    (( uptime_in_seconds.to_f / lifespan_in_seconds.to_f ) * 100).round(2)
  end
  
  def status
    current_event == nil ? "OK" : current_event.status.value
  end
  
end
