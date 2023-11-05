class Api::V1::AdminsController < ApplicationController
  def show
    @admin = Admin.find_by(id: params[:id])
  end
end
