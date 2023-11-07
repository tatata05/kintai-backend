class Api::V1::Admin::EmployeesController < ApplicationController
  def index
    @employees = Employee.all.page(params[:page])
  end

  def show
    @employee = Employee.find_by(id: params[:id])
  end

  def destroy
    employee = Employee.find_by(id: params[:id])
    if employee.email == 'guest_employee@example.com'
      redirect_to admin_home_path, alert: 'ゲスト従業員は削除できません。'
    else
      employee.destroy
      flash[:success] = "従業員を削除しました"
      redirect_to admin_employees_path
    end
  end
end
