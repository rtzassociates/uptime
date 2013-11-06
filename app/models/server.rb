class Server < ActiveRecord::Base
  attr_accessible :deployed_at_text, :description, :name, :ip_addresses_attributes
  
  has_many :ip_addresses, :dependent => :destroy
  accepts_nested_attributes_for :ip_addresses, allow_destroy: true
  
  validates :name, :presence => true, :uniqueness => true
  
  # Network.all.each do |network|
  #   define_method(network.name.downcase) do
  #     self.ip_addresses.joins(:network).where("networks.name" => network.name).first.try(:value)
  #   end
  # end
  
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
  
end
