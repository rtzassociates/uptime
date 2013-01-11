class User < ActiveRecord::Base
  attr_accessible :username, :password, :role, :emails_attributes, :service_ids
  
  before_save :prepare_password
  
  validates_presence_of :username
  validates_uniqueness_of :username, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_presence_of :password, :on => :create
  validates_length_of :password, :minimum => 4, :allow_blank => true
  
  has_many :subscriptions
  has_many :services, through: :subscriptions
  
  has_many :emails
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  has_many :problems
  has_many :resolutions
  
  def is_subscribed_to?(service)
    return true if subscriptions.find_by_service_id(service.id)
  end
  
  def username
    read_attribute(:username).capitalize
  end
  
  def self.authenticate(login, pass)
    user = find_by_username(login)
    return user if user && user.password == user.encrypt_password(pass)
  end
  
  def encrypt_password(pass)
    Digest::SHA1.base64digest(pass)
  end
  
  private
  
  def prepare_password
    unless password.blank?
      self.password = encrypt_password(password)
    end
  end
  
end
