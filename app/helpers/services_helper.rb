module ServicesHelper
  def users_subscribed_to(service)
    unless service.users.empty?
      subscription_list = service.users.collect { |u| link_to(u.username, user_path(u), :class => "link-large") }.to_sentence
      raw "#{subscription_list} #{pluralize_subscription_list(service)} subscribed to this service"
    end
  end
  
  def urls_for(service)
    unless service.urls.empty?
      url_list = service.urls.collect { |url| link_to(url.name, url.name, :class => "link-large") }.to_sentence
      raw "#{url_list}"
    end
  end
end

def pluralize_subscription_list(service)
  subscription_count = service.users.count
  subscription_count == 1 ? "has" : "have"
end