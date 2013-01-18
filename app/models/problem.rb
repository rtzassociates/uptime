class Problem < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :reported_at_text
  
  belongs_to :event, :dependent => :destroy
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :user_id, :description, :reported_at_text
  validate :reported_at_cannot_be_after_resolved_at
  
  def reported_at_text
    reported_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def reported_at_text=(time)
    self.reported_at = Chronic.parse(time) if time.present?
  rescue ArgumentError
    self.reported_at = Time.zone.now.strftime("%b %e, %Y at %l:%M %p")
  end
  
  def reported_at_cannot_be_after_resolved_at
    errors.add(:reported_at, "time cannot be later than resolved at time") if
    reported_at > event.resolution.resolved_at
  end
  
end
