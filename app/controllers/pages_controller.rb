class PagesController < ApplicationController
  include EventsHelper
  
  def home
    permitted_sort_options = [ "asc", "desc" ]
    if permitted_sort_options.include? params[:sort]
       @unresolved_events = Event.unresolved_sorted(params[:sort])
    else
       @unresolved_events = Event.unresolved_sorted("DESC")
    end
  end
end
