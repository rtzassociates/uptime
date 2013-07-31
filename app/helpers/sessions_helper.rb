module SessionsHelper
  def login(user)
    if params[:remember_me]
      cookies.permanent[:token] = user.token
    else
      cookies[:token] = user.token
    end
  end
end