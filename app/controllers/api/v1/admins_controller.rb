class AdminsController < ApplicationController
  def show
    @admin = Admin.find_by(id: params[:id])
  end
end
