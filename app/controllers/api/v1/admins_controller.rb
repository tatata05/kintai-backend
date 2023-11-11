class Api::V1::AdminsController < ApplicationController
  def show
    @admin = Admin.find_by(id: params[:id])
  end

  def current_admin
    # TODO: ログインをすると、headerに含まれている access-token, client, uid, の情報が必要。上記3つをsession? に保存しておく???
    @admin = current_api_v1_admin
  end
end
