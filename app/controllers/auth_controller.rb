class AuthController < ApplicationController
  def create
    @user = User.find_by(email: auth_params[:email])
    if @user&.authenticate(auth_params[:password])
      token, exp = JsonWebToken.encode(user_id: @user.id)
      render json: { token: token, exp: exp.strftime('%d-%m-%Y %H:%M'),
                     email: @user.email }
    else
      render json: { error: 'bad credentials' }, status: :forbidden
    end
  end

  private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end
