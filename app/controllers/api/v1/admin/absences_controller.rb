class Api::V1::Admin::AbsencesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @absence = Absence.find(params[:id])
  end

  def update
    ActiveRecord::Base.transaction do
      @absence = Absence.find(params[:id])
      @absence.update!(absence_params)
      case @absence.status
      when "approved"
        Notification.create!(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: "approval")
      when "rejected"
        Notification.create!(employee_id: @absence.shift.employee.id, absence_id: @absence.id, kind: "rejected")
      end
    end
    render status: 204, json: "success"
  rescue
    raise BadRequest
  end

  private

  def absence_params
    params.require(:absence).permit(:status)
  end
end
