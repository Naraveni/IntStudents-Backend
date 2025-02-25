class ApplicationController < ActionController::API
  include JsonWebToken
  before_action :authenticate_request
  def authenticate_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    decoded = jwt_decode(header)
    @current_user = User.find(decoded[:user_id])
  rescue JWT::ExpiredSignature, JWT::DecodeError
    render json: { message: 'Token expired or invalid. Please log in again.' }, status: :unauthorized
  end
end
