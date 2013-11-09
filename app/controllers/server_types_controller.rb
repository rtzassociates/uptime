class ServerTypesController < ApplicationController
  # GET /server_types
  # GET /server_types.json
  def index
    @server_types = ServerType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_types }
    end
  end

  # GET /server_types/1
  # GET /server_types/1.json
  def show
    @server_type = ServerType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_type }
    end
  end

  # GET /server_types/new
  # GET /server_types/new.json
  def new
    @server_type = ServerType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_type }
    end
  end

  # GET /server_types/1/edit
  def edit
    @server_type = ServerType.find(params[:id])
  end

  # POST /server_types
  # POST /server_types.json
  def create
    @server_type = ServerType.new(params[:server_type])

    respond_to do |format|
      if @server_type.save
        format.html { redirect_to server_types_path, notice: 'Server type was successfully created.' }
        format.json { render json: @server_type, status: :created, location: @server_type }
      else
        format.html { render action: "new" }
        format.json { render json: @server_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_types/1
  # PUT /server_types/1.json
  def update
    @server_type = ServerType.find(params[:id])

    respond_to do |format|
      if @server_type.update_attributes(params[:server_type])
        format.html { redirect_to server_types_path, notice: 'Server type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_types/1
  # DELETE /server_types/1.json
  def destroy
    @server_type = ServerType.find(params[:id])
    @server_type.destroy

    respond_to do |format|
      format.html { redirect_to server_types_url }
      format.json { head :no_content }
    end
  end
end
