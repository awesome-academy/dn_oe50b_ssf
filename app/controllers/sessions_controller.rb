class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user&.authenticate params[:session][:password]
      check_activated user
    else
      flash.now[:danger] = t "flash.invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def login user
    log_in user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
    redirect_back_or user
  end

  def check_activated user
    if user.activated
      log_in user
      redirect_back_or user
    else
      flash[:warning] = t "flash.warning"
      edirect_to root_url
    end
  end
end
