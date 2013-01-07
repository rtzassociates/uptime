module EventsHelper
  
  def services_affected_by(event)
    unless event.services.empty?
      service_list = event.services.collect { |s| link_to(s.name, service_path(s), :class => "link-large") }.to_sentence
      raw "#{service_list} #{pluralize_service_list(event)} affected by this event"
    end
  end
    
  def pluralize_service_list(event)
    service_count = event.services.count
    if event.closed?
      service_count == 1 ? "was" : "were"
    else
      service_count == 1 ? "is" : "are"
    end
  end

end
