class ServerTypesController < ApplicationController

  def index
    @server_types = ServerType.all
  end

  def show
    @server_type = ServerType.find(params[:id])
  end

  def new
    @server_type = ServerType.new
  end

  def edit
    @server_type = ServerType.find(params[:id])
  end

  def create
    @server_type = ServerType.new(params[:server_type])

    if @server_type.save
      redirect_to server_types_path, notice: 'Server type was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @server_type = ServerType.find(params[:id])

    if @server_type.update_attributes(params[:server_type])
      redirect_to server_types_path, notice: 'Server type was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @server_type = ServerType.find(params[:id])
    @server_type.destroy
    redirect_to server_types_url
  end
  
end
