class PasswordReset < ActiveRecord::Base
  attr_accessible :expires_at, :password_reset_token, :user_id
  
  before_create :prepare_password_reset
  
  belongs_to :user
  
  def prepare_password_reset
    generate_token
    set_expiration_date
  end
  
  def generate_token
    self.password_reset_token = SecureRandom.urlsafe_base64
  end
  
  def set_expiration_date
    self.expires_at = 1.day.from_now
  end
  
end