class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  helper_method :current_user

  def login_user!
    user = User.find_by_credentials(user_params)
    return nil unless user

    if user
      user.reset_session_token!
      session[:session_token] = user.session_token
      user
    end
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
