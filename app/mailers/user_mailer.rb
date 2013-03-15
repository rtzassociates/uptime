class UserMailer < ActionMailer::Base
  default from: "password_resets@uptime.getcare.com"

  def password_reset(user)
    @user = user
    mail :to => user.emails.first.address, :subject => "Password Reset"
  end
end