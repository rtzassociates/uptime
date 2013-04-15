class TaskNote < ActiveRecord::Base
  attr_accessible :content, :user_id, :task_id
  
  belongs_to :user
  belongs_to :task
end
