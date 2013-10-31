class EventMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  default :from => "uptime@uptime.getcare.com"

  def event_notification(event)
    @event = event
    sites = event.sites.map { |s| s.name }.join(", ")
    mail(:to => event.email_recipients, :subject => "#{event.status.value.upcase} -- #{sites}")
  end
end
