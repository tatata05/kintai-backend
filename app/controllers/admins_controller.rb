class Api::V1::AdminsController < ApplicationController
  def show
    @admin = Admin.find(params[:id])
    render json: @admin
  end
end
