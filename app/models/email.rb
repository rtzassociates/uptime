class Email < ActiveRecord::Base
  attr_accessible :address, :user_id  
  validates_format_of :address, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  belongs_to :user
  
  def self.addresses
    all.map { |e| e.address }
  end
end
