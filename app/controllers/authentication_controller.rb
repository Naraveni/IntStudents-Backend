class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request, only: [:login]
  def login
    @user = User.find_by_email(params[:email])
    if @user&.authenticate_request(params[:password])
      token = jwt_encode(user_id: @user.id)
      render json: { token: token }, status: :ok
    else
      render json: { error: 'unquthorized' }, status: :ok
    end
  end
end
