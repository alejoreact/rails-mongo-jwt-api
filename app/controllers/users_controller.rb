class UsersController < ApplicationController
  before_action :find_user, only: %i[update show destroy]
  before_action :authenticate!, only: :index

  def index
    users = User.all
    render json: users
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user
    else
      render json: user.errors, status: :bad_request
    end
  end

  def update
    @user.write_attributes(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors, status: :bad_request
    end
  end

  def show
    render json: @user
  end

  def destroy
    @user.destroy!
    render :no_content
  end

  private

  def user_params
    params.require(:user).permit(:password, :email,
                                 profile_attributes: %i[name last_name])
  end

  def find_user
    @user = User.find(params[:id])
  end
end
