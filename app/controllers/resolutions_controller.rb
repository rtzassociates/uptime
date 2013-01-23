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
      ResolutionMailer.resolution_notification(@resolution.event).deliver
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

  def current_resource
    @current_resource ||= Event.find(params[:event_id]).resolution if params[:event_id]
  end

end