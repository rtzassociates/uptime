class Site < ActiveRecord::Base
  attr_accessible :name, :user_ids, :description, :urls_attributes
  
  has_many :event_sites, :dependent => :destroy
  has_many :events, :through => :event_sites, :dependent => :destroy
  
  has_many :subscriptions, :dependent => :destroy
  has_many :users, through: :subscriptions, :dependent => :destroy
  
  has_many :urls, :dependent => :destroy
  accepts_nested_attributes_for :urls, allow_destroy: true
  
  validates_presence_of :name

  def total_downtime
    totals = Status.all.each_with_object([]) do |status, array|
      if status.include_in_calc
        array << events.send("#{status.value.downcase}").map { |e| e.duration }.sum
      end
    end
    totals.sum
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
    events.unresolved.empty? ? "OK" : events.unresolved.last.status.value
  end
  
end
