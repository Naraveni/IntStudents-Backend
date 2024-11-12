class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :autheticate_request

  def authenticate_request
    header = request.headers['Authorization']
    header = request.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  end
end
