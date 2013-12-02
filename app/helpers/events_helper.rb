module EventsHelper
  
  def sites_affected_by(event)
    unless event.sites.empty?
      site_list = event.sites.collect { |s| link_to(s.name, site_path(s), :class => "link-large") }.to_sentence
      raw "#{site_list} #{pluralize_site_list(event)} affected by this event"
    end
  end
    
  def pluralize_site_list(event)
    site_count = event.sites.count
    if event.resolved?
      site_count == 1 ? "was" : "were"
    else
      site_count == 1 ? "is" : "are"
    end
  end
  
  def status_for(status, size)
    div_for status, :class => "#{size}", :style => "background-color: #{status.background_color}; color: #{status.foreground_color}" do
      status.value.capitalize
    end
  end
  
  def edit_problem_for(event)
    link_to 'Edit Event', edit_event_path(event)
  end
  
  def destroy_action_for(event)
    link_to 'Delete Event', event_path(event), :method => :delete, :data => { :confirm => "Are you sure?" }, :class => "danger"
  end
  
  def edit_resolution_for(event)
    link_to 'Edit Resolution', edit_event_resolution_path(event)
  end
  
  def destroy_resolution_for(event)
    link_to 'Delete Resolution', event_resolution_path(event), :method => :delete, :data => { :confirm => "Are you sure?" }, :class => "danger"
  end

end
