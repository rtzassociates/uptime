class Event < ActiveRecord::Base
  attr_accessible :site_ids, :problem_attributes, :status_id
  
  has_many :event_sites, :dependent => :destroy
  has_many :sites, :through => :event_sites

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
  
  def reported_by
    problem.user
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
    joins(:problem).where("event_id NOT IN (SELECT event_id FROM resolutions)").order("problems.reported_at DESC")
  end
  
  def resolved?
    return true if resolution
  end
  
  def unresolved?
    return true if resolution.nil?
  end
  
  def email_recipients
    (sites.scoped.joins(:users => :emails).where("users.deleted_at" => nil).pluck(:address) + 
     Email.admin_addresses + 
     ( self.reported_by.emails.pluck(:address) unless self.reported_by.deleted? ).to_a ).uniq
  end
  
  def duration
    if self.unresolved?
      Time.zone.now - problem.reported_at
    else
      resolution.resolved_at - problem.reported_at
    end
  end
  
  def self.reported_on(date)
    joins(:problem).where("date(problems.reported_at) = ?", date.to_date)
  end
  
  def subscribers
    User.active.joins(:sites).where("site_id IN (?)", site_ids).uniq
  end

  def self.last_resolved_event
    Event.joins(:resolution).where("resolutions.resolved_at IS NOT NULL").last
  end
  
end
