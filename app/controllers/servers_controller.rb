class ServersController < ApplicationController
  caches_page :index
  
  # GET /servers
  # GET /servers.json
  def index
    @page_caching = true
    @servers = Server.deployed.order(:name).includes(:ip_addresses)
    @networks = Network.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @servers }
    end
  end
end
