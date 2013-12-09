module EventsHelper
  
  def sites_affected_by(event)
    unless event.sites.empty?
      site_list = event.sites.collect { |s| link_to(s.name, site_path(s)) }.to_sentence
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

end
