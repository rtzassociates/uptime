module ServersHelper
  def site_urls_for(server)
    unless server.site_urls.empty?
      raw server.site_urls.sort.collect { |url| link_to(url, url) }.to_sentence
    end
  end
end