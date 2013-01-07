class ResolutionsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
    @resolution = Resolution.new
  end
  
  def create
    @resolution = Resolution.new(params[:resolution])
    @resolution.event_id = params[:event_id]
    @resolution.user_id = current_user
    if @resolution.save
      redirect_to @resolution.event
    else
      render 'new'
    end
  end
  
  def edit
    @event = Event.find(params[:event_id])
    @resolution = @event.resolution
  end
  
  def update
    @event = Event.find(params[:event_id])
    @resolution = @event.resolution
    
    @resolution.update_attributes(params[:resolution])
    if @resolution.save
      redirect_to @event, notice: "Resolution successfully updated"
    else
      render 'edit'
    end
  end
  
  def destroy
    @event = Event.find(params[:event_id])
    @resolution = @event.resolution
    @resolution.destroy
    redirect_to @event, notice: "Resolution successfully destroyed"
  end
    
end