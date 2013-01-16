module EventsHelper
  
  def services_affected_by(event)
    unless event.services.empty?
      service_list = event.services.collect { |s| link_to(s.name, service_path(s), :class => "link-large") }.to_sentence
      raw "#{service_list} #{pluralize_service_list(event)} affected by this event"
    end
  end
    
  def pluralize_service_list(event)
    service_count = event.services.count
    if event.resolved?
      service_count == 1 ? "was" : "were"
    else
      service_count == 1 ? "is" : "are"
    end
  end
  
  def problem_for(event)
    raw "Reported by #{ link_to event.problem.user.username, event.problem.user, :class => 'link-large' } 
     on #{ event.problem.reported_at.strftime('%b %e, %Y at %l:%M %p') }
<<<<<<< HEAD
     ( #{ time_ago_in_words(event.problem.reported_at).capitalize } ago )"
=======
     (#{ time_ago_in_words(event.problem.reported_at).capitalize } ago)"
>>>>>>> 6b9405af6fa41a1ca3bdbe4fb8e6c1004b6f5300
  end
  
  def resolution_for(event)
    raw "Resolved by #{ link_to event.resolution.user.username, event.resolution.user, :class => 'link-large' } 
     on #{ event.resolution.resolved_at.strftime('%b %e, %Y at %l:%M %p') }
<<<<<<< HEAD
     ( #{ time_ago_in_words(event.resolution.resolved_at).capitalize } ago )"
  end
  
  def status_for(event, size)
    div_for event, :class => "event_status-#{size}", :style => "background-color: #{event.status.background_color}; color: #{event.status.foreground_color}" do
      event.status.value
    end
  end
  
  def edit_problem_for(event)
    link_to 'Edit Problem', edit_event_path(event), :class => 'nav small'
  end
  
  def destroy_action_for(event)
    link_to 'Destroy', event_path(event), :method => :delete, :data => { :confirm => "Are you sure?" }, :class => "nav small danger"
  end
  
  def edit_resolution_for(event)
    link_to 'Edit Resolution', edit_event_resolution_path(event), :class => 'nav small'
  end
  
  def destroy_resolution_for(event)
    link_to 'Destroy', event_resolution_path(event), :method => :delete, :data => { :confirm => "Are you sure?" }, :class => "nav small danger"
=======
     (#{ time_ago_in_words(event.resolution.resolved_at).capitalize } ago)"
>>>>>>> 6b9405af6fa41a1ca3bdbe4fb8e6c1004b6f5300
  end

end
