class NetworksController < ApplicationController
  
  def index
    @networks = Network.order(:name)
  end

  def show
    @network = Network.find(params[:id])
  end

  def new
    @network = Network.new
  end

  def edit
    @network = Network.find(params[:id])
  end

  def create
    @network = Network.new(params[:network])

    if @network.save
      expire_servers_cache
      redirect_to networks_path, notice: 'Network was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @network = Network.find(params[:id])

    if @network.update_attributes(params[:network])
      expire_servers_cache
      redirect_to networks_path, notice: 'Network was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @network = Network.find(params[:id])
    @network.destroy
    expire_servers_cache
    format.html { redirect_to networks_url }
  end
end
