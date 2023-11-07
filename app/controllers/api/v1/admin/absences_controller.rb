class Api::V1::Admin::AbsencesController < ApplicationController
  def show
    @absence = Absence.find_by(id: params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @absence = Absence.find_by(id: params[:id])
      @absence.update!(absence_params)
      case @absence.status
      when "approved"
        Notification.create!(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: "approval")
      when "rejected"
        Notification.create!(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: "rejected")
      end
    end
    render status: 204, json: "success"
  rescue => e
    render status: 400, json: e.message
  end

  private

  def absence_params
    params.require(:absence).permit(:status)
  end
end
