class EventsController < ApplicationController
  include EventsHelper
  
  def index
    @events = Event.reported_at
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
    @event.problem = Problem.new
  end
  
  def create
    @event = Event.new(params[:event])
    
    if @event.save
      redirect_to @event, :notice => "Event was successfully created."
    else
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => "Event was successfully updated."
    else
      render 'new'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, :notice => "Event was successfully destroyed"
  end
  
  def chart
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

end
