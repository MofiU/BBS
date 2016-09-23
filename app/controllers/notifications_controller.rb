class NotificationsController < ApplicationController

  before_action :set_notification, only: [:show]

  def index
    @notifications = current_user.notifications.order(created_at: :desc).page params[:page]
  end

  def show
    p @notification
    @notification.update!(read: true)
  end

  private

  def set_notification
    @notification = Notification.find params[:id]
  end

end
