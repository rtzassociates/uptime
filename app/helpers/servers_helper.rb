module ServersHelper
  def sites_for(server)
    unless server.sites.empty?
      site_list = server.sites.order(:name).collect { |site| link_to(site.name, site, :class => "link-large") }.to_sentence
      raw "#{site_list}"
    end
  end
  
  def site_urls_for(server)
    unless server.site_urls.empty?
      url_list = server.site_urls.sort.collect { |url| link_to(url, url, :class => "link-large") }.to_sentence
      raw "#{url_list}"
    end
  end
end
