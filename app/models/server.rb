class Server < ActiveRecord::Base
  attr_accessible :deployed_at_text, :description, :name

  def deployed_at_text
    deployed_at
  end
  
  def deployed_at_text=(time_str)
    self.deployed_at = Chronic.parse(time_str).utc
    if self.deployed_at.nil?
      @deployed_at_invalid = true
    end
  end
  
end
