class UsersController < AuthenticationController
  skip_before_action :authenticate_request, only: [:register]
  def register
    print('User Params', user_params)
    @user = User.new(user_params)
    if @user.save
      render json: { message: 'Registration Succesfull' }, status: :ok
    else
      render json: { message: @user.errors.full_messages }, status: :bad_request
    end
  end

  def show
    if @current_user.nil?
      render json: { message: 'User not found' }, status: :not_found
    else
      render json: { params: UserSerializer.new(@current_user).serializable_hash[:attributes], permissions: PermissionSerializer.new(@current_user.permissions).serializable_hash }, status: :ok

    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :username, :email, :password)
  end
end
