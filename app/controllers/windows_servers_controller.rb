class WindowsServersController < ApplicationController
  
  # GET /windows_servers
  # GET /windows_servers.json
  def index
    @windows_servers = WindowsServer.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @windows_servers }
    end
  end

  # GET /windows_servers/1
  # GET /windows_servers/1.json
  def show
    @windows_server = WindowsServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @windows_server }
    end
  end

  # GET /windows_servers/new
  # GET /windows_servers/new.json
  def new
    @windows_server = WindowsServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @windows_server }
    end
  end

  # GET /windows_servers/1/edit
  def edit
    @windows_server = WindowsServer.find(params[:id])
  end

  # POST /windows_servers
  # POST /windows_servers.json
  def create
    @windows_server = WindowsServer.new(params[:windows_server])

    respond_to do |format|
      if @windows_server.save
        expire_servers_cache
        format.html { redirect_to windows_servers_path, notice: 'Windows server was successfully created.' }
        format.json { render json: @windows_server, status: :created, location: @windows_server }
      else
        format.html { render action: "new" }
        format.json { render json: @windows_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /windows_servers/1
  # PUT /windows_servers/1.json
  def update
    @windows_server = WindowsServer.find(params[:id])

    respond_to do |format|
      if @windows_server.update_attributes(params[:windows_server])
        expire_servers_cache
        expire_fragment @windows_server
        format.html { redirect_to @windows_server, notice: 'Windows server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @windows_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /windows_servers/1
  # DELETE /windows_servers/1.json
  def destroy
    @windows_server = WindowsServer.find(params[:id])
    @windows_server.destroy
    expire_servers_cache
    respond_to do |format|
      format.html { redirect_to windows_servers_url }
      format.json { head :no_content }
    end
  end
  
end