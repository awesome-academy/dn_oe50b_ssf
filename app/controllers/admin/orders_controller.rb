class Admin::OrdersController < ApplicationController
  before_action :load_order, only: :update
  def index
    @orders = Order.status_asc.paginate page: params[:page],
      per_page: Settings.admin_order.per_page
  end

  def update
    if @order.update_status params[:stt]
      flash[:notice] = t "booking.update_booking.update_sucess"
    else
      flash[:alert] = t "booking.update_booking.update_fail"
    end
    respond_to do |format|
      format.html{render admin_orders_path}
      format.json{render json: flash.to_hash}
    end
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order

    flash[:warning] = t "booking.update_booking.not_exist_id"
    redirect_to admin_orders_path
  end
end
