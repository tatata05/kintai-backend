class Api::V1::Employee::MypagesController < ApplicationController
  # before_action :authenticate_employee!

  def show
    @employee = Employee.find(current_employee.id)
  end
end
