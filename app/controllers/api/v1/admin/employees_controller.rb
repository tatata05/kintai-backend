class Api::V1::Admin::EmployeesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @employees = Employee.all.page(params[:page])
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def destroy
    # devise標準のアカウント削除機能だと、対象アカウントでログインしないと削除できないため。
    @employee = Employee.find(params[:id]).destroy!
  end

  def unapplied_employees
    # unapplied通知を全て取得し、jb でemployee情報のみ取得する。
    @unapplied_employees_by_notifications = Notification.where(kind: "unapplied").preload(:employee)
  end
end
