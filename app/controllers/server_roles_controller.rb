class ServerRolesController < ApplicationController
  # GET /server_roles
  # GET /server_roles.json
  def index
    @server_roles = ServerRole.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_roles }
    end
  end

  # GET /server_roles/1
  # GET /server_roles/1.json
  def show
    @server_role = ServerRole.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_role }
    end
  end

  # GET /server_roles/new
  # GET /server_roles/new.json
  def new
    @server_role = ServerRole.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_role }
    end
  end

  # GET /server_roles/1/edit
  def edit
    @server_role = ServerRole.find(params[:id])
  end

  # POST /server_roles
  # POST /server_roles.json
  def create
    @server_role = ServerRole.new(params[:server_role])

    respond_to do |format|
      if @server_role.save
        format.html { redirect_to @server_role, notice: 'Server role was successfully created.' }
        format.json { render json: @server_role, status: :created, location: @server_role }
      else
        format.html { render action: "new" }
        format.json { render json: @server_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_roles/1
  # PUT /server_roles/1.json
  def update
    @server_role = ServerRole.find(params[:id])

    respond_to do |format|
      if @server_role.update_attributes(params[:server_role])
        format.html { redirect_to @server_role, notice: 'Server role was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_roles/1
  # DELETE /server_roles/1.json
  def destroy
    @server_role = ServerRole.find(params[:id])
    @server_role.destroy

    respond_to do |format|
      format.html { redirect_to server_roles_url }
      format.json { head :no_content }
    end
  end
end
