class Api::V1::EmployeeAuth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  # 従業員登録はadminのみが行える。
  before_action :authenticate_admin!

  private

  # sign_up時に情報を登録できるように、既存のdeviseのsign_up_paramsをオーバーライドする
  def sign_up_params
    params.required(:registration).permit(:name, :email, :gender, :age, :address, :phone_number, :emergency_phone_number, :password, :password_confirmation)
  end
end
