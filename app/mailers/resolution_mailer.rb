class ResolutionMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  default :from => "notify@uptime.getcare.com"

  def resolution_notification(event)
    @event = event
    services = event.services.map { |s| s.name }.join(", ")
    mail(:to => event.recipients, :subject => "RESOLVED -- #{services}")
  end
end
