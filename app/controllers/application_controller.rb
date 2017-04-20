class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  helper_method :current_user

  def login_user!
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    #if write params[:password], has to match the view in new.html.erb where name would have to be name="password".  Params is ruby's way of accessing the data stored in the params that is entered by the user in the form in name = user[password]

    if user
      user.reset_session_token!  # do not have to reset session token, although doesn't hurt

      #session, flash are methods from Rails that packages the session/flash for us.  session[:session_token] accesses the session_token attribute within session

      session[:session_token] = user.session_token
      return user
    else
      nil
    end
  end


end
