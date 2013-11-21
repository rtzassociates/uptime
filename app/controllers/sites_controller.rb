class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    @events = @site.events.page(params[:page]).per_page(5)
  end

  def index
    @sites = Site.search(params[:search]).page(params[:page]).per_page(50)
  end

  def new
    @site = Site.new
  end

  def edit
    @site = Site.find(params[:id])
  end
  
  def create
    @site = Site.new(params[:site])
    if @site.save
      redirect_to @site, :notice => 'Site successfully created.'
    else
      render 'new'
    end
  end
  
  def update
    @site = Site.find(params[:id])
    
    if @site.update_attributes(params[:site])
      expire_fragment @site
      
      redirect_to @site, :notice => 'Site successfully updated.'
    else
      render 'edit'
    end
  end
  
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path, :notice => 'Site successfully destroyed.'
  end
end
