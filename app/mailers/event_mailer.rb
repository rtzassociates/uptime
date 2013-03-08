class EventMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  default :from => "notify@uptime.getcare.com"

  def event_notification(event)
    @event = event
    services = event.services.map { |s| s.name }.join(", ")
    mail(:to => event.email_recipients, :subject => "#{event.status.value.upcase} -- #{services}")
  end
end
