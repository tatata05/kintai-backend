class Api::V1::AdminAuth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  before_action :authenticate_admin!

  private

  # sign_up時にnameを登録できるように、既存のdeviseのsign_up_paramsをオーバーライドする
  def sign_up_params
    params.required(:registration).permit(:name, :email, :password, :password_confirmation)
  end
end
