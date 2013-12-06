class Resolution < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :resolved_at_text
  
  belongs_to :event
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :event_id, :user_id, :description, :resolved_at_text
  validate :resolved_at_cannot_be_before_reported_at
  
  def resolved_at_text
    resolved_at
  end
  
  def resolved_at_text=(time_str)
    self.resolved_at = Chronic.parse(time_str)
    if self.resolved_at.nil?
      errors.add(:resolved_at, "is invalid.")
    end
  end
  
  def validate
    errors.add(:resolved_at, "is invalid") if @resolved_at_invalid
  end
  
  def resolved_at_cannot_be_before_reported_at
    unless resolved_at.nil?
      errors.add(:resolved_at, "time cannot be earlier than reported at time") if
      resolved_at < event.problem.reported_at
    end
  end
end
