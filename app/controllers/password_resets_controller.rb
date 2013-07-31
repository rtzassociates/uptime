class PasswordResetsController < ApplicationController
  skip_before_filter :login_required, :only => [ :new, :create, :edit, :update ]
  
  def new
  end

  def create
    email = params[:email] + "@rtzassociates.com"
    user = Email.find_user_by_address(email)
    if user
      password_reset = PasswordReset.create!(:user_id => user.id)
      UserMailer.password_reset(user).deliver
    end
    redirect_to new_session_path, :notice => "Email sent with password reset instructions."
  end
  
  def edit
    password_reset = PasswordReset.find_by_password_reset_token(params[:id])
    @user = password_reset.user
  end
  
  def update
    password_reset = PasswordReset.find_by_password_reset_token(params[:id])
    @user = password_reset.user
    
    if @user.update_attributes(params[:user])
      @user.password_reset.destroy
      redirect_to new_session_url, :notice => "Password has been reset. Please log in with your new password."
    else
      render :edit
    end
  end
  
end