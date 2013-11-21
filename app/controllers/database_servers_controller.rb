class DatabaseServersController < ApplicationController
  
  def index
    @database_servers = DatabaseServer.order(:name)
  end

  def show
    @database_server = DatabaseServer.find(params[:id])
  end

  def new
    @database_server = DatabaseServer.new
  end

  def edit
    @database_server = DatabaseServer.find(params[:id])
  end

  def create
    @database_server = DatabaseServer.new(params[:database_server])

    if @database_server.save
      expire_servers_cache
      redirect_to database_servers_path, notice: 'Database server was successfully created.'
    else
      render action: "new"
    end

  end

  def update
    @database_server = DatabaseServer.find(params[:id])

    if @database_server.update_attributes(params[:database_server])
      expire_servers_cache
      expire_fragment @database_server
      redirect_to @database_server, notice: 'Database server was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @database_server = DatabaseServer.find(params[:id])
    @database_server.destroy
    expire_servers_cache
    redirect_to database_servers_url, notice: 'Database server was successfully deleted.'
  end
  
end
