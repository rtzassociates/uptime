class EventsController < ApplicationController
  include EventsHelper
  
  def index
    @events = Event.reported_at.page(params[:page]).per_page(25)
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
    @event.problem.user_id = current_user.id
    if @event.save
      EventMailer.event_notification(@event).deliver
      redirect_to @event, :notice => "Event was successfully created"
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
      redirect_to @event, :notice => "Event was successfully updated"
    else
      render 'new'
    end
  end
  
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_path, :notice => "Event was successfully destroyed"
  end
  
  private
  
  def current_resource
    @current_resource ||= Event.find(params[:id]) if params[:id]
  end

end
