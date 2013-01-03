class Service < ActiveRecord::Base
  attr_accessible :name, :status_id
  
  belongs_to :status
  has_many :events
  
  has_many :subscriptions
  has_many :users, through: :subscriptions
  
  def current_event
    events.active.first
  end
  
  def total_downtime
    events.outages.map { |e| e.duration }.sum
  end
  
  def time_since_creation
    Time.zone.now.to_i - created_at.to_i
  end
  
  def total_uptime
    time_since_creation - total_downtime
  end
  
  def uptime_percentage
    ( total_uptime.to_f / time_since_creation.to_f ) * 100
  end
  
end
