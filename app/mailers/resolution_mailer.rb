class ResolutionMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  default :from => "uptime@uptime.getcare.com"

  def resolution_notification(event)
    @event = event
    sites = event.sites.map { |s| s.name }.join(", ")
    mail(:to => event.email_recipients, :subject => "RESOLVED -- #{sites}")
  end
end
