class Completion < ActiveRecord::Base
  attr_accessible :description, :task_id, :user_id
  
  belongs_to :task
  belongs_to :user
end
