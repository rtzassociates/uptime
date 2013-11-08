class SitesController < ApplicationController
  def show
    @site = Site.find(params[:id])
    @events = @site.events.page(params[:page]).per_page(5)
    
    unless params[:start_date] == ''
      @start_date = params[:start_date] ? params[:start_date].to_date : 1.week.ago.to_date
    else
      @start_date = 1.week.ago.to_date
    end
  
    unless params[:end_date] == ''
      @end_date = params[:end_date] ? params[:end_date].to_date : Date.today
    else
      @end_date = Date.today
    end
    
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
      redirect_to @site, :notice => 'Site successfully created'
    else
      render 'new'
    end
  end
  
  def update
    @site = Site.find(params[:id])
    
    if @site.update_attributes(params[:site])
      expire_fragment @site
      
      redirect_to @site, :notice => 'Site successfully updated'
    else
      render 'edit'
    end
  end
  
  def destroy
    @site = Site.find(params[:id])
    @site.destroy
    redirect_to sites_path, :notice => 'Site successfully destroyed'
  end
end
