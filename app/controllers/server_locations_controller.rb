class ServerLocationsController < ApplicationController
  # GET /server_locations
  # GET /server_locations.json
  def index
    @server_locations = ServerLocation.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_locations }
    end
  end

  # GET /server_locations/1
  # GET /server_locations/1.json
  def show
    @server_location = ServerLocation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_location }
    end
  end

  # GET /server_locations/new
  # GET /server_locations/new.json
  def new
    @server_location = ServerLocation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_location }
    end
  end

  # GET /server_locations/1/edit
  def edit
    @server_location = ServerLocation.find(params[:id])
  end

  # POST /server_locations
  # POST /server_locations.json
  def create
    @server_location = ServerLocation.new(params[:server_location])

    respond_to do |format|
      if @server_location.save
        format.html { redirect_to server_locations_path, notice: 'Server location was successfully created.' }
        format.json { render json: @server_location, status: :created, location: @server_location }
      else
        format.html { render action: "new" }
        format.json { render json: @server_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_locations/1
  # PUT /server_locations/1.json
  def update
    @server_location = ServerLocation.find(params[:id])

    respond_to do |format|
      if @server_location.update_attributes(params[:server_location])
        format.html { redirect_to server_locations_path, notice: 'Server location was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_locations/1
  # DELETE /server_locations/1.json
  def destroy
    @server_location = ServerLocation.find(params[:id])
    @server_location.destroy

    respond_to do |format|
      format.html { redirect_to server_locations_url }
      format.json { head :no_content }
    end
  end
end
