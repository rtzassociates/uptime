module SitesHelper
  def subscribers_for(site)
    unless site.users.empty?
      subscription_list = site.users.active.collect { |u| link_to(u.username, user_path(u), :class => "link-large") }.to_sentence
      raw "#{subscription_list} #{pluralize_subscription_list(site)} subscribed to this site"
    end
  end
  
  def urls_for(site)
    unless site.urls.empty?
      raw site.urls.collect { |url| link_to(url.name, url.name) }.to_sentence
    end
  end
  
end

def pluralize_subscription_list(site)
  subscription_count = site.users.count
  subscription_count == 1 ? "has" : "have"
end