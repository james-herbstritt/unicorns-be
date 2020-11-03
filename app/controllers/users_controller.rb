# frozen_string_literal: true

# Controller used for creating users, and giving acess to user content
class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def index
    @users = User.all
    if @users
      render json: { users: @users }
    else
      render json: { status: :internal_server_error, errors: ['no users found'] }
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      render json: { user: @user }
    else
      render json: { status: :internal_server_error, errors: ['user not found'] }
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { status: :created, user: @user }
    else
      render json: { status: :internal_server_error, errors: @user.errors.full_messages }
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
