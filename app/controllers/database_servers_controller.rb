class DatabaseServersController < ApplicationController
  # GET /database_servers
  # GET /database_servers.json
  def index
    @database_servers = DatabaseServer.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @database_servers }
    end
  end

  # GET /database_servers/1
  # GET /database_servers/1.json
  def show
    @database_server = DatabaseServer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @database_server }
    end
  end

  # GET /database_servers/new
  # GET /database_servers/new.json
  def new
    @database_server = DatabaseServer.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @database_server }
    end
  end

  # GET /database_servers/1/edit
  def edit
    @database_server = DatabaseServer.find(params[:id])
  end

  # POST /database_servers
  # POST /database_servers.json
  def create
    @database_server = DatabaseServer.new(params[:database_server])

    respond_to do |format|
      if @database_server.save
        format.html { redirect_to database_servers_path, notice: 'Database server was successfully created.' }
        format.json { render json: @database_server, status: :created, location: @database_server }
      else
        format.html { render action: "new" }
        format.json { render json: @database_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /database_servers/1
  # PUT /database_servers/1.json
  def update
    @database_server = DatabaseServer.find(params[:id])

    respond_to do |format|
      if @database_server.update_attributes(params[:database_server])
        format.html { redirect_to @database_server, notice: 'Database server was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @database_server.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /database_servers/1
  # DELETE /database_servers/1.json
  def destroy
    @database_server = DatabaseServer.find(params[:id])
    @database_server.destroy

    respond_to do |format|
      format.html { redirect_to database_servers_url }
      format.json { head :no_content }
    end
  end
end
