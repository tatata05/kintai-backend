class Api::V1::Employee::ShiftsController < ApplicationController
  before_action :authenticate_employee!
  # before_action :correct_employee, only: [:edit, :update, :destroy]

  def index
    @shifts = current_employee.shifts.eager_load(:absence).where(absence: {status: ["unapproved", "rejected"]}, status: ["approved", "unapproved"]).or(current_employee.shifts.where(absence: {id: nil}, status: ["approved", "unapproved"]))
  end

  def create
    ActiveRecord::Base.transaction do
      @shift = current_employee.shifts.build(shift_params)
      notification = Notification.find_by(employee_id: current_employee.id, kind: "unapplied")

      #シフト未申請通知があった場合に、シフトを申請したらその通知を削除する
      notification.destroy! if notification.present?

      # 同じ従業員から同じ時間でのシフト申請が行われた時は、例外を発生させる。
      if overlapping_time?
        raise StandardError.new("その時間帯はすでにシフトを申請しています")
      end

      @shift.save!
      Notification.create!(employee_id: current_employee.id, shift_id: @shift.id, kind: "application")
    end
    render status: 201, json: "success"
  rescue => e
    # エラーハンドリングをうまくできれば、ここでのrescueは必要ないかも
    render status: 400, json: e.message
  end

  # def show
  #   @shift = Shift.find_by(id: params[:id])
  # end

  # def edit
  # end

  # def update
  #   @shift.assign_attributes(shift_params)
  #   if overlapping_time?
  #     flash.now[:danger] = "その時間帯はすでにシフトを申請しています"
  #     render "edit"
  #   elsif @shift.save
  #     flash[:success] = "更新しました"
  #     redirect_to employee_shift_path
  #   else
  #     flash.now[:danger] = "更新に失敗しました"
  #     render "edit"
  #   end
  # end

  # def destroy
  #   @shift.destroy
  #   flash[:success] = "シフト申請を削除しました"
  #   redirect_to employee_shifts_path
  # end

  private

  def shift_params
    params.require(:shift).permit(:start_time, :end_time, :status)
  end

  # def correct_employee
  #   @shift = Shift.find_by(id: params[:id])
  #   return if @shift.employee_id == current_employee.id

  #   flash[:danger] = "権限がありません"
  #   redirect_to employee_shifts_path
  # end

  def overlapping_time?
    current_employee.shifts.where('end_time > ? and ? > start_time', @shift.start_time, @shift.end_time).exists?
  end
end
