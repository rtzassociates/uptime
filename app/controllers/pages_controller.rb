class PagesController < ApplicationController
  include EventsHelper
  skip_before_filter :login_required, :only => [ :home ]
  before_filter :check_logged_in
  
  def home
    @unresolved_events = Event.unresolved
    @last_resolved_event = Event.last_resolved_event
  end
  
  private
  
  def check_logged_in
    redirect_to login_url unless logged_in?
  end
  
end
