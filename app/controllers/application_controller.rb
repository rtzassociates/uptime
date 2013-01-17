class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  before_filter :authenticate
  before_filter :authorize, only: [ :edit, :destroy ]
  
  private
  
    def authenticate
      unless current_user
        redirect_to new_session_url, :notice => "Please log in"
      end
    end
    
    def authorize
      if current_user && !current_user.admin?
        redirect_to root_url, alert: "Not authorized"
      end
    end
end
