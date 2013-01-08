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
     on #{ event.problem.reported_at.strftime('%b%e, %Y at %l:%M %p') }
     #{ time_ago_in_words(event.problem.reported_at).capitalize } ago"
  end
  
  def resolution_for(event)
    raw "Resolved by #{ link_to event.resolution.user.username, event.resolution.user, :class => 'link-large' } 
     on #{ event.resolved_at.strftime('%b%e, %Y at %l:%M %p') }
     #{ time_ago_in_words(event.resolved_at).capitalize } ago"
  end
  
  def events_chart_data_weekly
    (1.week.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_monthly
    (1.month.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_quarterly
    (3.months.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end
  
  def events_chart_data_annually
    (1.year.ago.to_date..Date.today).map do |date|
      {
        created_at: date,
        event_count: Event.where("date(created_at) = ?", date).count,
        outages: Event.outages.where("date(created_at) = ?", date).count,
        slowdowns: Event.slowdowns.where("date(created_at) = ?", date).count,
        errors: Event.errors.where("date(created_at) = ?", date).count,
        restarts: Event.restarts.where("date(created_at) = ?", date).count
      }
    end
  end

end
