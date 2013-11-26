class GenericServer < Server
  attr_accessor :new_server_role_name
  before_save :create_server_role_from_name
  belongs_to :server_role

  def create_server_role_from_name
    create_server_role(:name => new_server_role_name) unless new_server_role_name.blank?
  end
end
