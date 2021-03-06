module UsersHelper
  def subscriptions_for user
    raw user.sites.collect { |s| link_to(s.name, site_path(s)) }.to_sentence
  end
end
