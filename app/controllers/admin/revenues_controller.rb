class Admin::RevenuesController < ApplicationController
  before_action :logged_in_user, :check_admin

  def index; end

  def search_revenue
    date = params[:date].to_date
    @orders_by_date = Order.find_date_accept(date)
    if @orders_by_date.present?
      @total = Order.find_date_accept(date).find_sum_day
    else
      flash[:danger] = t ".danger"
      redirect_to admin_revenues_path
    end
  end
end
