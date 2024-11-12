# class User
class User < ApplicationRecord
  require 'securerandom'
  has_secure_password
  validates :email, presence: true
  validates :password, presence: true
  validates :username, presence: true

  def create
    @user = User.new(params)
    if @user.save
      render json: { message: 'User Successfully Save' }, status: :created
    else
      render json: { message: 'Error While Creating User' }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.permit(:username, :email, :password)
  end
end
