class ApplicationController < ActionController::Base
  include ControllerAuthentication
  protect_from_forgery

  before_filter :authenticate
  before_filter :authorize
  
  delegate :allow?, to: :current_permission
  helper_method :allow?
  
  around_filter :user_time_zone, if: :current_user
  
  private
  
    def authenticate
      unless current_user
        redirect_to new_session_url, :notice => "Please log in"
      end
    end
    
    def current_resource
      nil
    end

    def authorize
      if !current_permission.allow?(params[:controller], params[:action], current_resource)
        redirect_to root_url, alert: "Not authorized."
      end
    end
    
    def current_permission
      @current_permission ||= Permission.new(current_user)
    end
    
    def user_time_zone(&block)
      Time.use_zone(current_user.time_zone, &block)
    end
end
