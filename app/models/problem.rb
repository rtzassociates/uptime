class Problem < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :reported_at_text
  
  belongs_to :event, :dependent => :destroy
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :user_id, :description, :reported_at_text
  validate :reported_at_cannot_be_after_resolved_at
  
  def reported_at_text
    reported_at
  end
  
  def reported_at_text=(time_str)
    self.reported_at = Chronic.parse(time_str).utc
    if self.reported_at.nil?
      @reported_at_invalid = true
    end
  end
  
  def reported_at_cannot_be_after_resolved_at
    unless event.nil? || event.resolution.nil?
      errors.add(:reported_at, "time cannot be later than resolved at time") if
      reported_at > event.resolution.resolved_at
    end
  end
  
  def validate
    errors.add(:reported_at, "is invalid") if @reported_at_invalid
  end
  
end
