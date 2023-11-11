class Api::V1::Admin::AdminsController < ApplicationController
  # before_action :authenticate_admin!

  def index
    @admins = Admin.all.page(params[:page])
  end

  def show
    @admin = Admin.find(params[:id])
  end

  def current_admin
    @admin = current_api_v1_admin
  end
end
