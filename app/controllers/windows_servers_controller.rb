class WindowsServersController < ApplicationController
  
  def index
    @windows_servers = WindowsServer.order(:name)
  end

  def show
    @windows_server = WindowsServer.find(params[:id])
  end

  def new
    @windows_server = WindowsServer.new
  end

  def edit
    @windows_server = WindowsServer.find(params[:id])
  end

  def create
    @windows_server = WindowsServer.new(params[:windows_server])

    if @windows_server.save
      expire_servers_cache
      redirect_to windows_servers_path, notice: 'Windows server was successfully created.'
    else
      render action: "new"
    end

  end

  def update
    @windows_server = WindowsServer.find(params[:id])

    if @windows_server.update_attributes(params[:windows_server])
      expire_servers_cache
      expire_fragment @windows_server
      redirect_to @windows_server, notice: 'Windows server was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @windows_server = WindowsServer.find(params[:id])
    @windows_server.destroy
    expire_servers_cache
    redirect_to windows_servers_url
  end
  
end