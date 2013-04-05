module ControllerAuthentication
  def self.included(controller)
    controller.send :helper_method, :current_user, :logged_in?, :redirect_to_target_or_default
  end

  def current_user
    @current_user ||= User.find_by_token( cookies[:token]) if cookies[:token]
  end

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      store_target_location
      redirect_to new_session_url, :alert => "You must first log in before accessing this page."
    end
  end

  def redirect_to_target_or_default(default, *args)
    redirect_to(session[:return_to] || default, *args)
    session[:return_to] = nil
  end

  private

  def store_target_location
    session[:return_to] = request.url
  end
end