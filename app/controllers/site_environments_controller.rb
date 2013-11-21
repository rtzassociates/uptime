class SiteEnvironmentsController < ApplicationController
  # GET /site_environments
  # GET /site_environments.json
  def index
    @site_environments = SiteEnvironment.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @site_environments }
    end
  end

  # GET /site_environments/1
  # GET /site_environments/1.json
  def show
    @site_environment = SiteEnvironment.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @site_environment }
    end
  end

  # GET /site_environments/new
  # GET /site_environments/new.json
  def new
    @site_environment = SiteEnvironment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @site_environment }
    end
  end

  # GET /site_environments/1/edit
  def edit
    @site_environment = SiteEnvironment.find(params[:id])
  end

  # POST /site_environments
  # POST /site_environments.json
  def create
    @site_environment = SiteEnvironment.new(params[:site_environment])

    respond_to do |format|
      if @site_environment.save
        format.html { redirect_to site_environments_path, notice: 'Site environment was successfully created.' }
        format.json { render json: @site_environment, status: :created, location: @site_environment }
      else
        format.html { render action: "new" }
        format.json { render json: @site_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /site_environments/1
  # PUT /site_environments/1.json
  def update
    @site_environment = SiteEnvironment.find(params[:id])

    respond_to do |format|
      if @site_environment.update_attributes(params[:site_environment])
        format.html { redirect_to site_environments_path, notice: 'Site environment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @site_environment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /site_environments/1
  # DELETE /site_environments/1.json
  def destroy
    @site_environment = SiteEnvironment.find(params[:id])
    @site_environment.destroy

    respond_to do |format|
      format.html { redirect_to site_environments_url }
      format.json { head :no_content }
    end
  end
end
