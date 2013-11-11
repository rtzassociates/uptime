class XenServersController < ApplicationController
  
  # GET /xen_servers
  # GET /xen_servers.json
  def index
    @xen_servers = XenServer.order(:name)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @xen_servers }
    end
  end

  # GET /xen_servers/1
  # GET /xen_servers/1.json
  def show
    @xen_server = XenServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @xen_server }
    end
  end

  # GET /xen_servers/new
  # GET /xen_servers/new.json
  def new
    @xen_server = XenServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @xen_server }
    end
  end

  # GET /xen_servers/1/edit
  def edit
    @xen_server = XenServer.find(params[:id])
  end

  # POST /xen_servers
  # POST /xen_servers.json
  def create
    @xen_server = XenServer.new(params[:xen_server])

    respond_to do |format|
      if @xen_server.save
        expire_servers_cache
        format.html { redirect_to xen_servers_path, notice: 'Xen server was successfully created.' }
        format.json { render json: @xen_server, status: :created, location: @xen_server }
      else
        format.html { render action: "new" }
        format.json { render json: @xen_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /xen_servers/1
  # PUT /xen_servers/1.json
  def update
    @xen_server = XenServer.find(params[:id])

    respond_to do |format|
      if @xen_server.update_attributes(params[:xen_server])
        expire_servers_cache
        expire_fragment @xen_server
        format.html { redirect_to @xen_server, notice: 'Xen server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @xen_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /xen_servers/1
  # DELETE /xen_servers/1.json
  def destroy
    @xen_server = XenServer.find(params[:id])
    @xen_server.destroy
    expire_servers_cache
    respond_to do |format|
      format.html { redirect_to xen_servers_url }
      format.json { head :no_content }
    end
  end
  
end