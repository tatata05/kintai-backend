class Api::V1::Employee::AbsencesController < ApplicationController
  before_action :authenticate_employee!
  before_action :correct_employee, only: [:show, :destroy]

  def new
    @absence = Absence.new
    # left_outer_joinsによってShiftとAbsenceを結合し、その中で欠勤申請がされていないものかつ、承認済みのもの(承認前のシフトの場合は編集・削除できるから)
    @shifts = current_employee.shifts.left_outer_joins(:absence).where(absence: { id: nil }, status: "approved")
  end

  def create
    ActiveRecord::Base.transaction do
      @absence = Absence.create!(absence_params)
      Notification.create!(employee_id: current_employee.id, absence_id: @absence.id, kind: "application")
    end
    render status: 204, json: "success"
  rescue
    raise BadRequest
  end

  def show
  end

  def destroy
    @absence.destroy!
  end

  private

  def absence_params
    params.require(:absence).permit(:shift_id)
  end

  def correct_employee
    @absence = Absence.find(params[:id])
    return if @absence.shift.employee_id == current_employee.id

    raise ActiveRecord::RecordNotFound
  end
end
