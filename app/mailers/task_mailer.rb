class TaskMailer < ActionMailer::Base
  default :from => "uptime@uptime.getcare.com"

  def task_notification(task)
    @task = task
    mail(:to => @task.email_recipients, :subject => "A New Task Was Created")
  end
end