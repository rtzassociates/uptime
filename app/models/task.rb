class Task < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :assigned_user_ids 
  belongs_to :user
  has_many :user_tasks
  has_many :assigned_users, through: :user_tasks, :source => :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :task_notes
  
  has_one :completion
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user_id
  
  default_scope :order => 'created_at DESC'
  
  def unassigned?
    assigned_users.empty?
  end
  
  def is_assigned_to?(user)
    assigned_users.include?(user)
  end
  
  def completed?
    return true if completion
  end
  
  def self.uncompleted
    uncompleted_tasks = Task.all.each_with_object(uncompleted_tasks = []) do |task|
      unless task.completed?
        uncompleted_tasks << task
      end
    end
  end
  
  def self.unassigned
    unassigned_tasks = Task.all.each_with_object(unassigned_tasks = []) do |task|
      if task.unassigned?
        unassigned_tasks << task
      end
    end
  end
  
  def self.assigned_to(user)
    tasks = Task.all.each_with_object(tasks_for_user = []) do |task|
      if task.is_assigned_to? user
        tasks_for_user << task
      end
    end
  end
  
  def email_recipients
    Email.admin_addresses
  end

end