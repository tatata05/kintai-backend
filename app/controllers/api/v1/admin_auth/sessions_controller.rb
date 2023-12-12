class Api::V1::AdminAuth::SessionsController < DeviseTokenAuth::SessionsController
  wrap_parameters false
end
