class Api::V1::Admin::EmployeesController < ApplicationController
  def index
    @employees = Employee.all.page(params[:page])
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end
end
