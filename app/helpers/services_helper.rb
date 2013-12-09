module ServicesHelper
  def users_subscribed_to(service)
    unless service.users.empty?
      subscription_list = service.users.collect { |u| link_to(u.username, user_path(u)) }.to_sentence
      raw "#{subscription_list} #{pluralize_subscription_list(service)} subscribed to this service"
    end
  end
end

def pluralize_subscription_list(service)
  subscription_count = service.users.count
  subscription_count == 1 ? "has" : "have"
end