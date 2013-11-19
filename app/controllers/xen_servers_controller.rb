class XenServersController < ApplicationController
  
  def index
    @xen_servers = XenServer.order(:name)
  end

  def show
    @xen_server = XenServer.find(params[:id])
  end

  def new
    @xen_server = XenServer.new
  end

  def edit
    @xen_server = XenServer.find(params[:id])
  end

  def create
    @xen_server = XenServer.new(params[:xen_server])

    if @xen_server.save
      expire_servers_cache
      redirect_to xen_servers_path, notice: 'Xen server was successfully created.'
    else
      render action: "new" 
    end
  end

  def update
    @xen_server = XenServer.find(params[:id])

    if @xen_server.update_attributes(params[:xen_server])
      expire_servers_cache
      expire_fragment @xen_server
      redirect_to @xen_server, notice: 'Xen server was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @xen_server = XenServer.find(params[:id])
    @xen_server.destroy
    expire_servers_cache
    redirect_to xen_servers_url
  end
  
end