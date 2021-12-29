class NotificationsController < ApplicationController
  before_action :load_notification

  def show
    check_read if @notification.checked.nil?
  end

  def check_read
    @notification.update(checked: Time.zone.now)
  end

  private

  def load_notification
    @notification = Notification.find_by id: params[:id]
    return if @notification.present?

    flash[:danger] = t "flash.not_found"
    redirect_to root_url
  end
end
