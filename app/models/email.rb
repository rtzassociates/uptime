class Email < ActiveRecord::Base
  attr_accessible :address, :user_id
  
  belongs_to :user
  
  def self.addresses
    all.map { |e| e.address }
  end
end
