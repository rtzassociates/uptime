class StatusesController < ApplicationController
  def index
    @statuses = Status.all
  end
  
  def show
    @status = Status.find(params[:id])
    @events = @status.events.page(params[:page]).per_page(25)
  end
  
  def new
    @status = Status.new
  end
  
  def create
    @status = Status.new(params[:status])
    if @status.save
      redirect_to statuses_path, :notice => 'Status successfully created'
    else
      render 'new'
    end
  end
  
  def edit
    @status = Status.find(params[:id])
  end
  
  def update
    @status = Status.find(params[:id])
    if @status.update_attributes(params[:status])
      redirect_to statuses_path, :notice => 'Status successfully created'
    else
      render 'new'
    end
  end
end