class EventMailer < ActionMailer::Base
  default :from => "mailer@uptime.getcare.com"

  def event_notification(event)
    mail(:to => event.recipients, :subject => "A New Event Has Been Created")
  end
end
