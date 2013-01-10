class Service < ActiveRecord::Base
  attr_accessible :name, :user_ids
  
  has_many :event_services
  has_many :events, :through => :event_services
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  def unresolved_events
    events.unresolved
  end
  
  def total_downtime
    events.outage.map { |e| e.duration }.sum
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
    unresolved_events.empty? ? "OK" : unresolved_events.last.status.value
  end
  
end
