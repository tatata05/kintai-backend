class Api::V1::Admin::EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employees = Employee.all.page(params[:page])
  end

  def show
    @employee = Employee.find(params[:id])
  end
end
