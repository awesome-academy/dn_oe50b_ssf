class AccountActivationsController < ApplicationController
  def edit
    user = User.find_by email: params[:email]
    if user && !user.activated && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = t "account_activations_controller.account_activate"
      redirect_to login_url
    else
      flash[:danger] = "account_activations_controller.account_danger"
      redirect_to root_url
    end
  end
end
