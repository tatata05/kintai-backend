class Api::V1::AdminsController < ApplicationController
  def show
    @admin = Admin.find_by(id: params[:id])
  end

  def current_admin
    @admin = current_api_v1_admin
  end
end
