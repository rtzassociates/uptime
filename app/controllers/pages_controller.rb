class PagesController < ApplicationController
  include EventsHelper
  
  def home
    @unresolved_events = Event.unresolved
    @last_resolved_event = Event.last_resolved_event
  end
end
