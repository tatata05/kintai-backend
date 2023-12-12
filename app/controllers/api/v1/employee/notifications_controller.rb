class Api::V1::Employee::NotificationsController < ApplicationController
  before_action :authenticate_employee!
  before_action :correct_employee, only: %i[update]

  def index
    notifications = current_employee.notifications.where(kind: ["approval", "rejected", "unapplied"])
    notifications = notifications.where(read: true) if params[:read] == "true"
    notifications = notifications.where(read: false) if params[:read] == "false"
    @notifications = notifications.by_recently_created.page(params[:page])
  end

  def update
    @notification.update!(read: true) if @notification.read == false
    render status: 204, json: "success"
  end

  private

  def correct_employee
    @notification = Notification.find(params[:id])
    return if @notification.employee_id == current_employee.id

    raise ActiveRecord::RecordNotFound
  end
end
