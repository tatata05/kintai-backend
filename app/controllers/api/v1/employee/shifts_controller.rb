class Api::V1::Employee::ShiftsController < ApplicationController
  before_action :authenticate_employee!
  before_action :correct_employee, only: %i[show update destroy]

  def index
    @shifts = current_employee.shifts.eager_load(:absence).where(absence: {status: ["unapproved", "rejected"]}, status: ["approved", "unapproved"]).or(current_employee.shifts.where(absence: {id: nil}, status: ["approved", "unapproved"]))
  end

  def create
    ActiveRecord::Base.transaction do
      @shift = current_employee.shifts.build(shift_params)

      # シフト申請が、同じ従業員・時間の時は処理を終了。
      if overlapping_time?
        return render status: 400, json: { errorCode: "BadRequest", message: ["その時間帯はすでにシフトを申請しています。"] }
      end

      notification = Notification.find_by(employee_id: current_employee.id, kind: "unapplied")
      #シフト未申請通知があった場合に、シフトを申請したらその通知を削除する
      notification.destroy! if notification.present?

      @shift.save!
      Notification.create!(employee_id: current_employee.id, shift_id: @shift.id, kind: "application")
    end
    render status: 201, json: "success"
  rescue
    raise BadRequest
  end

  def show
  end

  def update
    @shift.assign_attributes(shift_params)
    # シフト申請が、同じ従業員・時間の時は処理を終了。
    if overlapping_time?
      return render status: 400, json: { errorCode: "BadRequest", message: ["その時間帯はすでにシフトを申請しています。"] }
    end

    @shift.save!
    render status: 204, json: "success"
  end

  def destroy
    @shift.destroy!
  end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time)
  end

  def correct_employee
    @shift = Shift.find(params[:id])
    return if @shift.employee_id == current_employee.id

    raise ActiveRecord::RecordNotFound
  end

  def overlapping_time?
    current_employee.shifts.where('end_time > ? and ? > start_time', @shift.start_time, @shift.end_time).exists?
  end
end
