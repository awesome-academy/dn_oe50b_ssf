class User::OrdersController < ApplicationController
  def index
    @orders = current_user.orders.date_desc.paginate page: params[:page],
                           per_page: Settings.admin_order.per_page
  end
end
