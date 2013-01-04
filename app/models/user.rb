class User < ActiveRecord::Base
  attr_accessible :password, :username
  
  has_many :subscriptions
  has_many :services, through: :subscriptions
  
  has_many :emails
  
  def email_addresses
    emails
  end
end
