class SessionsController < ApplicationController

  skip_before_filter :login_required, :only => [ :new, :create ]
  skip_before_filter :authorize, :only => [ :destroy ]
  
  def new
  end

  def create
    user = User.authenticate(params[:login], params[:password])
    if user
      if params[:remember_me]
        cookies.permanent[:token] = user.token
      else
        cookies[:token] = user.token
      end
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:error] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to root_url, :notice => "You have been logged out."
  end
end
