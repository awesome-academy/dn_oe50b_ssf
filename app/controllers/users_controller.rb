class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    load_user_or_redirect
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "user_controller.check_email"
      redirect_to root_url
    else
      flash[:warning] = t "user_controller.create_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:email, :password, :password_confirmation)
  end

  def load_user_or_redirect
    @user = User.find_by id: params[:id]
    return if @user.present?

    flash[:warning] = t "user_controller.user_not_found"
    redirect_to root_url
  end
end
