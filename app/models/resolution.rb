class Resolution < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :resolved_at_text
  
  belongs_to :event
  belongs_to :user
  
  has_many :comments, :as => :commentable
  
  def resolved_at_text
    resolved_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def resolved_at_text=(time)
    self.resolved_at = Chronic.parse(time) if time.present?
  rescue ArgumentError
    self.resolved_at = Time.zone.now.strftime("%b %e, %Y at %l:%M %p")
  end
end
