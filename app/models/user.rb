class User < ActiveRecord::Base
  attr_accessible :username, :password, :password_confirmation, :emails_attributes, :service_ids, :first, :last, :phone, :admin, :time_zone
  attr_accessor :password
  
  before_save :prepare_password
  
  validates_presence_of :username
  validates_uniqueness_of :username, :allow_blank => true
  validates_format_of :username, :with => /^[-\w\._@]+$/i, :allow_blank => true, :message => "should only contain letters, numbers, or .-_@"
  validates_presence_of :password, :on => :create
  validates_confirmation_of :password
  validates_length_of :password, :minimum => 4, :allow_blank => true
  validates_inclusion_of :time_zone, in: ActiveSupport::TimeZone.zones_map(&:name)
  
  has_many :subscriptions, :dependent => :destroy
  has_many :services, through: :subscriptions
  
  has_many :emails, :dependent => :destroy
  accepts_nested_attributes_for :emails, allow_destroy: true
  
  has_many :problems, :dependent => :destroy
  has_many :resolutions, :dependent => :destroy
  
  def is_subscribed_to?(service)
    return true if subscriptions.find_by_service_id(service.id)
  end
  
  def username
    read_attribute(:username).capitalize
  end
  
  def self.authenticate(login, pass)
    user = find_by_username(login)
    return user if user && user.password_hash == user.encrypt_password(pass)
  end
  
  def encrypt_password(pass)
    BCrypt::Engine.hash_secret(pass, token)
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
  
  private
  
  def prepare_password
    unless password.blank?
      self.token = BCrypt::Engine.generate_salt
      self.password_hash = encrypt_password(password)
    end
  end
  
end
