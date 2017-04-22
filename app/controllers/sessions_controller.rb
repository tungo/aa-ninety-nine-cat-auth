class SessionsController < ApplicationController
  before_action :check_logged_in, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(user_params)
    if login_user!(user)
      redirect_to cats_url
    else
      flash.now[:errors] = 'Can not login'
      redirect_to new_session_url
    end
  end

  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil

      redirect_to new_session_url
    end
  end

  def check_logged_in
    redirect_to cats_url if current_user
  end
end
