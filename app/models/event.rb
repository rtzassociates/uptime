class Event < ActiveRecord::Base
  attr_accessible :service_ids, :problem_attributes, :status_id
  
  has_many :event_services, :dependent => :destroy
  has_many :services, :through => :event_services

  belongs_to :status
  
  has_one :problem
  accepts_nested_attributes_for :problem
  
  has_one :resolution
  
  class << self
    Status.all.each do |status|
      define_method(status.value.downcase) do
        send("where", :status_id => Status.find_by_value(status.value.downcase))
      end
    end
  end
  
  def self.status_hash
    Status.select(:value).each_with_object({}) do |s, h|
      h[s.value] = Event.send("#{s.value.downcase}")
    end
  end

  def self.reported_at
    find(:all,
         :joins => "LEFT JOIN `problems` ON problems.event_id = events.id",
         :select => "events.*, problems.reported_at",
         :order => "problems.reported_at DESC")
  end
  
  def self.resolved
    joins(:resolution)
  end
  
  def self.unresolved
    where("event_id NOT IN (SELECT event_id FROM resolutions)")
  end

  def self.unresolved_sorted(sort)
    joins(:problem).where("event_id NOT IN (SELECT event_id FROM resolutions)").order("problems.reported_at #{sort}")
  end
  
  def resolved?
    return true if resolution
  end
  
  def unresolved?
    return true if resolution.nil?
  end
  
  def duration
    if self.unresolved?
      Time.zone.now - problem.reported_at
    else
      resolution.resolved_at - problem.reported_at
    end
  end
  
  def self.reported_on(date)
    joins(:problem).where("date(datetime(problems.reported_at, 'localtime')) = ?", date)
  end
  
end
