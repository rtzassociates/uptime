class EventMailer < ActionMailer::Base
  default :from => "mailer@uptime.getcare.com"

  def event_notification(event)
    @event = event
    services = event.services.map { |s| s.name }.join(", ")
    mail(:to => event.recipients, :subject => "#{event.status.value.upcase} -- #{services}")
  end
end
