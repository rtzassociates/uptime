class CompletionMailer < ActionMailer::Base
  default :from => "uptime@uptime.getcare.com"

  def completion_notification(completion)
    @task = completion.task
    mail(:to => @task.email_recipients, :subject => "A Task Was Completed")
  end
end