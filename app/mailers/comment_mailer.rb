class CommentMailer < ActionMailer::Base
  add_template_helper(EventsHelper)
  default :from => "uptime@uptime.getcare.com"

  def comment_notification(comment)
    @comment = comment
    mail(:to => comment.recipients, :subject => "#{comment.user.username} left a comment -- #{comment.sites}")
  end
end
