class Resolution < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :resolved_at_text
  
  belongs_to :event
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :event_id, :user_id, :description, :resolved_at_text
  validate :resolved_at_cannot_be_before_reported_at
  
  def resolved_at_text
    resolved_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def resolved_at_text=(time)
    self.resolved_at = Chronic.parse(time) if time.present?
  rescue ArgumentError
    self.resolved_at = Time.zone.now.strftime("%b %e, %Y at %l:%M %p")
  end
  
  def resolved_at_cannot_be_before_reported_at
     errors.add(:resolved_at, "time cannot be earlier than reported at time") if
     resolved_at < event.problem.reported_at
  end
end
