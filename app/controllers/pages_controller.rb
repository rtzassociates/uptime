class PagesController < ApplicationController
  def home
    @current_events = Event.current
  end
end
