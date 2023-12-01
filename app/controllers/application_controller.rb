class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  class Forbidden < ActionController::ActionControllerError; end

  rescue_from StandardError, with: :render_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from Forbidden, with: :render_403
  rescue_from ActionController::ParameterMissing, with: :render_400

  def show
    raise env['action_dispatch.exception']
  end

  def render_400
    render status: 400, json: { errorCode: "BadRequest", message: ["不正な入力値です。"] }
  end

  def render_403
    render status: 403, json: { errorCode: "Forbidden", message: ["権限がありません。"] }
  end

  def render_404
    render status: 404, json: { errorCode: "NotFound", message: ["対象データが存在しません。"] }
  end

  def render_500
    render status: 500, json: { errorCode: "InternalServerError", message: ["サーバーエラー"] }
  end
end
