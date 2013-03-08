class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  validates_presence_of :content, :user_id

  def klass
    commentable_type.classify.constantize
  end
  
  def event
    klass.find(commentable_id).event
  end

  def services
    event.services.map { |s| s.name }.join(", ")
  end
  
  def recipients
    event.email_recipients
  end
end
