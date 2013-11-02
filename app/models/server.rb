class Server < ActiveRecord::Base
  attr_accessible :deployed_at_text, :description, :name, :ip_addresses_attributes
  has_many :ip_addresses
  accepts_nested_attributes_for :ip_addresses, allow_destroy: true
  
  Interface.all.each do |interface|
    define_method(interface.name.downcase) do
      lambda { self.ip_addresses.joins(:interface).where("interfaces.name" => interface.name).first.try(:value) }.call
    end
  end
  
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
