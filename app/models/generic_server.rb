class GenericServer < Server
  before_validation :create_server_role_from_name
  belongs_to :server_role
  attr_accessor :new_server_role_name
  attr_accessible :new_server_role_name

  def create_server_role_from_name
    create_server_role(:role => new_server_role_name) unless new_server_role_name.blank?
  end
end
