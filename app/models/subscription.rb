class Subscription < ActiveRecord::Base
  attr_accessible :site_id, :user_id
  
  belongs_to :site
  belongs_to :user
end
