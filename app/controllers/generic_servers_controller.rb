class GenericServersController < ApplicationController
  
  def index
    @generic_servers = GenericServer.order(:name)
  end

  def show
    @generic_server = GenericServer.find(params[:id])
  end

  def new
    @generic_server = GenericServer.new
  end

  def edit
    @generic_server = GenericServer.find(params[:id])
  end

  def create
    @generic_server = GenericServer.new(params[:generic_server])

    if @generic_server.save
      expire_servers_cache
      redirect_to generic_servers_path, notice: 'Generic server was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @generic_server = GenericServer.find(params[:id])

    if @generic_server.update_attributes(params[:generic_server])
      expire_servers_cache
      expire_fragment @generic_server
      redirect_to @generic_server, notice: 'Generic server was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @generic_server = GenericServer.find(params[:id])
    @generic_server.destroy
    expire_servers_cache
    redirect_to generic_servers_url
  end
  
end
