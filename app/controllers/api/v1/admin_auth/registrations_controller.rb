class Api::V1::AdminAuth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  private

  def sign_up_params
    params.required(:registration).permit(:name, :email, :password)
  end
end
