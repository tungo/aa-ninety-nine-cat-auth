class UsersController < ApplicationController
  def new
    render :new
  end

  def create
    user = User.new(user_params)
    if user.save
      login_user!(user)
      redirect_to root_url
    else
      flash.now[:errors] = user.errors.full_message
      render :new
    end
  end
end
