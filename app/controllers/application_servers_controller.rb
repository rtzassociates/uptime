class ApplicationServersController < ApplicationController
  
  # GET /application_servers
  # GET /application_servers.json
  def index
    @application_servers = ApplicationServer.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @application_servers }
    end
  end

  # GET /application_servers/1
  # GET /application_servers/1.json
  def show
    @application_server = ApplicationServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @application_server }
    end
  end

  # GET /application_servers/new
  # GET /application_servers/new.json
  def new
    @application_server = ApplicationServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @application_server }
    end
  end

  # GET /application_servers/1/edit
  def edit
    @application_server = ApplicationServer.find(params[:id])
  end

  # POST /application_servers
  # POST /application_servers.json
  def create
    @application_server = ApplicationServer.new(params[:application_server])

    respond_to do |format|
      if @application_server.save
        expire_servers_cache
        format.html { redirect_to application_servers_path, notice: 'Application server was successfully created.' }
        format.json { render json: @application_server, status: :created, location: @application_server }
      else
        format.html { render action: "new" }
        format.json { render json: @application_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /application_servers/1
  # PUT /application_servers/1.json
  def update
    @application_server = ApplicationServer.find(params[:id])

    respond_to do |format|
      if @application_server.update_attributes(params[:application_server])
        expire_servers_cache
        expire_fragment @application_server
        format.html { redirect_to @application_server, notice: 'Application server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @application_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /application_servers/1
  # DELETE /application_servers/1.json
  def destroy
    @application_server = ApplicationServer.find(params[:id])
    @application_server.destroy
    expire_servers_cache
    respond_to do |format|
      format.html { redirect_to application_servers_url }
      format.json { head :no_content }
    end
  end
  
end
