class TaskNote < ActiveRecord::Base
  attr_accessible :content, :user_id, :task_id
  
  validates_presence_of :content
  validates_presence_of :user_id
  validates_presence_of :task_id
  
  belongs_to :user
  belongs_to :task
end
