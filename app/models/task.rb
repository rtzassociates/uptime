class Task < ActiveRecord::Base
  attr_accessible :description, :name, :user_id, :assigned_user_ids 
  belongs_to :user
  has_many :assignments
  has_many :assigned_users, through: :assignments, :source => :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :task_notes
  
  has_one :completion
  
  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :user_id
  
  default_scope :order => 'tasks.created_at DESC'
  
  scope :uncompleted, :include => :completion, :conditions => "completions.id IS NULL"
  scope :unassigned, :include => :assigned_users, :conditions => "users.id IS NULL"
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      order("id DESC")
    end
  end
  
  def unassigned?
    assigned_users.empty?
  end
  
  def is_assigned_to?(user)
    assigned_users.include?(user)
  end
  
  def completed?
    return true if completion
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
  
  def unassigned_users
    if assigned_users.empty?
      User.all
    else
      User.where("id NOT IN (?)", assigned_users.map { |u| u.id })
    end
  end

end