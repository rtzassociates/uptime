class ServicesController < ApplicationController
  def show
    @service = Service.find(params[:id])
    @events = @service.events.page(params[:page]).per_page(25)
    
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
    @services = Service.page(params[:page]).per_page(25)
  end

  def new
    @service = Service.new
  end

  def edit
    @service = Service.find(params[:id])
  end
  
  def create
    @service = Service.new(params[:service])
    if @service.save
      redirect_to @service, :notice => 'Service created successfully.'
    else
      render 'new'
    end
  end
  
  def update
    @service = Service.find(params[:id])
    if @service.update_attributes(params[:service])
      redirect_to @service, :notice => 'Service updated successfully.'
    else
      render 'edit'
    end
  end
  
  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, :notice => 'Service destroyed successfully.'
  end
end
