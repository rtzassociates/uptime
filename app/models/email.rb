class Email < ActiveRecord::Base
  attr_accessible :address, :user_id  
  validates_format_of :address, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  belongs_to :user
  
  validates_presence_of :address
  validates_uniqueness_of :address
  
  def self.addresses
    all.map { |e| e.address }
  end
  
  def self.admin_addresses
    Email.joins(:user).where("users.admin" => true).pluck(:address)
  end
  
  def self.find_user_by_address(address)
    email = Email.find_by_address(address)
    email.user if email
  end
  
end
