class UserMailer < ActionMailer::Base
  default from: "uptime@uptime.getcare.com"

  def password_reset(user)
    @user = user
    mail :to => user.email_address, :subject => "Password Reset"
  end
end
