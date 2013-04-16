class TaskNoteMailer < ActionMailer::Base
  default :from => "uptime@uptime.getcare.com"

  def task_note_notification(task_note)
    @task = task_note.task
    @task_note = task_note
    mail(:to => @task.email_recipients, :subject => "A Note Was Added To A Task")
  end
end