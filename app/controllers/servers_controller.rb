class ServersController < ApplicationController
  
  # GET /servers
  # GET /servers.json
  def index
    @servers = Server.deployed.order(:name).includes(:ip_addresses)
    @networks = Network.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers }
    end
  end
end
