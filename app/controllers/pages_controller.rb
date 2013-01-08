class PagesController < ApplicationController
  include EventsHelper
  
  def home
    @current_events = Event.current
  end
end
