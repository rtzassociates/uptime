class Event < ActiveRecord::Base
  attr_accessible :service_ids, :problem_attributes, :status_id
  
  has_many :event_services, :dependent => :destroy
  has_many :services, :through => :event_services

  belongs_to :status
  
  has_one :problem, :dependent => :destroy
  accepts_nested_attributes_for :problem
  
  has_one :resolution, :dependent => :destroy
  
  validates_presence_of :status_id
  
  class << self
    Status.all.each do |status|
      define_method(status.value.downcase) do
        send("where", :status_id => Status.find_by_value(status.value))
      end
    end
  end
  
  def self.status_hash
    Status.select(:value).each_with_object({}) do |s, h|
      h[s.value] = Event.send("#{s.value.downcase}")
    end
  end

  def self.reported_at
    joins(:problem).order("problems.reported_at DESC")
  end
  
  def self.reported_by(user)
    joins(:problem).where("problems.user_id = ?", user.id)
  end
  
  def self.resolved_by(user)
    joins(:resolution).where("resolutions.user_id = ?", user.id)
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
  
  def recipients
    recipients = services.each_with_object(arr = []) do |service|
      service.users.each do |user|
        user.emails.each do |email|
          arr << email.address
        end
      end
    end
    
    # admins should always be emailed
    admins = User.all.each_with_object(arr = []) do |user|
      if user.admin?
        user.emails.each do |email|
          arr << email.address
        end
      end
    end
    
    recipients += admins
    
    # deduplicate recipients
    recipients.uniq
  end
  
  def duration
    if self.unresolved?
      Time.zone.now - problem.reported_at
    else
      resolution.resolved_at - problem.reported_at
    end
  end
  
  def self.reported_on(date)
    joins(:problem).where("date(CONVERT_TZ(problems.reported_at, system_time_zone)) = ?", date)
  end
  
end
