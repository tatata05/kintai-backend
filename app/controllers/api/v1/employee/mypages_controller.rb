class Api::V1::Employee::MypagesController < ApplicationController
  before_action :authenticate_employee!

  # 従業員詳細ページのためのレスポンス(マイページ)
  def show
    @employee = Employee.find(current_employee.id)
  end

  # ヘッダーで従業員名を出すためのレスポンス
  def profile
    @profile = Employee.find(current_employee.id)
  end
end
