class Problem < ActiveRecord::Base
  attr_accessible :event_id, :user_id, :description, :reported_at_text
  
  belongs_to :event, :dependent => :destroy
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  def reported_at_text
    reported_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def reported_at_text=(time)
    self.reported_at = Chronic.parse(time) if time.present?
  rescue ArgumentError
    self.reported_at = Time.zone.now.strftime("%b %e, %Y at %l:%M %p")
  end
  
end
