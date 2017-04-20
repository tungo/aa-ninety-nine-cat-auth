class SessionsController < ApplicationController
  before_action :logged_in?, only: [:new]

  def new
    render :new
  end

  def create
    user = login_user!
    if user
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!  #reset for security
      session[:session_token] = nil

      redirect_to new_session_url
    end
  end

  def logged_in?
    redirect_to cats_url if current_user
  end
end
