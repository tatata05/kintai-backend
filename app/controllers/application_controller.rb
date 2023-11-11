class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  class BadRequest < ActionController::ActionControllerError; end
  class ForbiddenError < ActionController::ActionControllerError; end
  # class Api::V1::Admin::NotAuthorized < ActionController::ActionControllerError; end

  # rescue_from StandardError, with: :render_500
  # rescue_from ActionController::BadRequest, with: :render_400
  # rescue_from ForbiddenError, with: :render_403
  rescue_from BadRequest, with: :render_400
  # rescue_from NotAuthorized, with: :render_401
  
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def show
    raise env['action_dispatch.exception']
  end

  def render_400(err)
    render status: 400, json: err
  end

  def render_401(err)
    render status: 401, json: "hogehoge"
  end

  # def render_403(err)
  #   render status: 403, json: err
  # end

  def render_404
    render status: 404, json: { errorCode: "NotFound" ,message: ["対象データが存在しません。"] }
  end

  def render_500
    render status: 500, json: { errorCode: "InternalServerError" ,message: ["サーバーエラー"] }
  end
end
