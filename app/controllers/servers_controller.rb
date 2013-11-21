class ServersController < ApplicationController
  def index
    @servers = Server.deployed.order(:name).includes(:ip_addresses)
    @networks = Network.order(:name)
  end
end
