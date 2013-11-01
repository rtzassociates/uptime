class SessionsController < ApplicationController
  include SessionsHelper
  skip_before_filter :login_required, :only => [ :new, :create ]
  skip_before_filter :authorize, :only => [ :destroy ]
  
  def new
  end

  def create
    user = User.authenticate(params[:username], params[:password])
    if user && !user.deleted?
      login user  
      redirect_to_target_or_default root_url, :notice => "Logged in successfully"
    else
      flash.now[:error] = "Invalid login or password"
      render :action => 'new'
    end
  end

  def destroy
    cookies.delete(:token)
    redirect_to login_url, :notice => "You have been logged out"
  end
end
