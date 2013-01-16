class Comment < ActiveRecord::Base
  attr_accessible :commentable_id, :commentable_type, :content, :user_id
  
  belongs_to :commentable, :polymorphic => true
  belongs_to :user
  
  def last_in?(collection)
    collection.last == self
  end
end
