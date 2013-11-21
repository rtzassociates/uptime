class ServerLocationsController < ApplicationController

  def index
    @server_locations = ServerLocation.order(:name)
  end

  def show
    @server_location = ServerLocation.find(params[:id])
  end

  def new
    @server_location = ServerLocation.new
  end

  def edit
    @server_location = ServerLocation.find(params[:id])
  end

  def create
    @server_location = ServerLocation.new(params[:server_location])

    if @server_location.save
      redirect_to server_locations_path, notice: 'Server location was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @server_location = ServerLocation.find(params[:id])

    if @server_location.update_attributes(params[:server_location])
      redirect_to server_locations_path, notice: 'Server location was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @server_location = ServerLocation.find(params[:id])
    @server_location.destroy
    redirect_to server_locations_url
  end
  
end
