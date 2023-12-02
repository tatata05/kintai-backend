class Api::V1::Admin::ShiftsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @shifts = Shift.eager_load(:employee, :absence).where(status: ["approved", "unapproved"])
  end

  def show
    @shift = Shift.eager_load(:employee).find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @shift = Shift.find(params[:id])
      @shift.update!(shift_params)
      case @shift.status
      when "approved"
        Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "approval")
      when "rejected"
        Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "rejected")
      end
    end
    render status: 204, json: "success"
  end

  private

  def shift_params
    params.require(:shift).permit(:status)
  end
end