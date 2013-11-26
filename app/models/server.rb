class Server < ActiveRecord::Base
  attr_accessible :deployed_at_text, :description, :name, :ip_addresses_attributes, :server_type_id, :server_location_id, :server_role_id
  
  has_many :ip_addresses, :dependent => :destroy
  accepts_nested_attributes_for :ip_addresses, allow_destroy: true
  
  belongs_to :server_type
  belongs_to :server_location
  
  validates :name, :presence => true, :uniqueness => true
  
  def self.deployed
    where("deployed_at IS NOT NULL")
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
  
  def method_missing(method_sym, *arguments, &block)
    self.ip_addresses.joins(:network).where("networks.name" => method_sym.to_s).first.try(:value)
  end
  
  def public_ip_address
    self.ip_addresses.joins(:network).where("networks.name" => "public").first.try(:value)
  end
  
end
