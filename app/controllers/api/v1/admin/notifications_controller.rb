class Api::V1::Admin::NotificationsController < ApplicationController
  def index
    notifications = Notification.where(kind: ["application", "approval_pending", "unapplied"])
    notifications = notifications.where(read: true) if params[:read] == "true"
    notifications = notifications.where(read: false) if params[:read] == "false"
    @notifications = notifications.by_recently_created.page(params[:page])
  end

  def update
    notification = Notification.find_by(id: params[:id])
    notification.update(read: true) if notification.read == false
    render status: 204, json: "success"
  end
end
