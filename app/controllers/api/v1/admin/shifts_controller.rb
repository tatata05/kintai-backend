class Api::V1::Admin::ShiftsController < ApplicationController
  def index
    @shifts = Shift.eager_load(:employee, :absence).where(status: ["approved", "unapproved"])
  end

  # def show
  #   @shift = Shift.find_by(id: params[:id])
  # end

  # def update
  #   ActiveRecord::Base.transaction do
  #     @shift = Shift.find_by(id: params[:id])
  #     @shift.update!(shift_params)
  #     case @shift.status
  #     when "approved"
  #       Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "approval")
  #     when "rejected"
  #       Notification.create!(employee_id: @shift.employee.id, shift_id: @shift.id, kind: "rejected")
  #     end
  #   end
  #   flash[:success] = "更新しました"
  #   redirect_to admin_shifts_path
  # rescue
  #   flash[:danger] = "更新に失敗しました"
  #   redirect_to admin_shifts_path
  # end

  private

  def shift_params
    params.require(:shift).permit(:status)
  end
end