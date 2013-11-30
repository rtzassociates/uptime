class Server < ActiveRecord::Base
  attr_accessible :deployed_at_text, :description, :name, :ip_addresses_attributes, :server_type_id, :server_location_id, :server_role_id, :public_ip_address
  
  has_many :ip_addresses, :dependent => :destroy
  accepts_nested_attributes_for :ip_addresses, allow_destroy: true
  
  belongs_to :server_role
  belongs_to :server_type
  belongs_to :server_location
  
  validates :name, :presence => true, :uniqueness => true
  validates :deployed_at, :presence => true
  
  ValidIpAddressRegex = /^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$/
  validates_format_of :public_ip_address, :with => ValidIpAddressRegex, :allow_blank => true

  def edit_route_path
    "edit_#{self.type.titleize.split(/\s+/).join("_").downcase}_path"
  end

  def role_name
    server_role ? server_role.role.titlecase : type.titlecase
  end
  
  def route
    type.titlecase.downcase.split(' ').join('_')
  end 

  def self.deployed
    where("deployed_at IS NOT NULL")
  end
  
  def deployed_at_text
    deployed_at
  end
  
  def deployed_at_text=(time_str)
    self.deployed_at = Chronic.parse(time_str)
    if self.deployed_at.nil?
      @deployed_at_invalid = true
    end
  end
  
  def method_missing(method_sym, *arguments, &block)
    self.ip_addresses.joins(:network).where("networks.name" => method_sym.to_s).first.try(:value)
  end
  
  def self.public_servers
    where("servers.public_ip_address IS NOT NULL")
  end
  
end
