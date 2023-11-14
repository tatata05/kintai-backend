class Api::V1::Employee::NotificationsController < ApplicationController
  # before_action :authenticate_employee!

  def index
    notifications = current_employee.notifications.where(kind: ["approval", "rejected", "unapplied"])
    notifications = notifications.where(read: true) if params[:read] == "true"
    notifications = notifications.where(read: false) if params[:read] == "false"
    @notifications = notifications.by_recently_created.page(params[:page])
  end

  def update
    notification = Notification.find(params[:id])
    notification.update!(read: true) if notification.read == false
    render status: 204, json: "success"
  end
end
