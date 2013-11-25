class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :email_address,
                  :site_ids, :first, :last, :phone, :admin, :time_zone,
                  :token
                  
  attr_accessor :password
  
  before_save :prepare_password
  
  validates_presence_of :username
  validates_uniqueness_of :username, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
  
  validates_format_of :email_address, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  has_many :subscriptions, :dependent => :destroy
  has_many :sites, through: :subscriptions
  
  has_many :problems, :dependent => :destroy
  has_many :resolutions, :dependent => :destroy
  has_one :password_reset
  
  has_many :created_tasks, :foreign_key => 'user_id', :class_name => "Task"
  
  has_many :assignments
  has_many :assigned_tasks, through: :assignments, :source => :task
  
  has_many :task_notes
  
  scope :active, where(:deleted_at => nil)
  
  def self.search(search)
    if search
      where('username LIKE ?', "%#{search}%")
    else
      order("username ASC")
    end
  end

  def is_subscribed_to?(site)
    return true if subscriptions.find_by_site_id(site.id)
  end
  
  def has_accepted?(task)
    return true if task.is_assigned_to?(self)
  end
  
  def self.authenticate(login, pass)
    user = find_by_username(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end
  
  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, token)
  end
  
  def deleted?
    deleted_at
  end
  
  def full_name
    unless first.blank? && last.blank?
      "#{first} #{last}".titleize
    else
      username
    end
  end
  
  def admin?
    return true if admin
  end
  
  def event_feed
    Event.feed_for(self)
  end
  
  def self.admins
    User.where(:admin => true)
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.token = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
  
end
