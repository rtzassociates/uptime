class ApplicationServersController < ApplicationController
  
  def index
    @application_servers = ApplicationServer.order(:name)
  end

  def show
    @application_server = ApplicationServer.find(params[:id])
  end

  def new
    @application_server = ApplicationServer.new
  end

  def edit
    @application_server = ApplicationServer.find(params[:id])
  end

  def create
    @application_server = ApplicationServer.new(params[:application_server])
  
    if @application_server.save
      expire_servers_cache
      redirect_to application_servers_path, notice: 'Application server was successfully created.'
    else
      render action: "new"
    end
    
  end

  def update
    @application_server = ApplicationServer.find(params[:id])

    if @application_server.update_attributes(params[:application_server])
      expire_servers_cache
      expire_fragment @application_server
      redirect_to @application_server, notice: 'Application server was successfully updated.'
    else
      render action: "edit"
    end

  end

  def destroy
    @application_server = ApplicationServer.find(params[:id])
    @application_server.destroy
    expire_servers_cache
    redirect_to application_servers_url, notice: 'Application server was successfully deleted.'
  end
  
end
