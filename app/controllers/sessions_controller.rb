class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: %i[create]

  def create
    @user = User.find_by(email: session_params[:email])
    command = AuthenticateUser.call(session_params[:email], session_params[:password])

    if @user && command.success?
      cookies[:token] = command.result
      current_user = @user
      render json: { logged_in: true, user: @user }

    else
      render json: {
        status: :unauthorized,
        errors: ['no such user', 'verify credentials and try again or sign up']
      }
    end
  end

  def logged_in?
    if current_user
      render json: { logged_in: true, user: current_user }
    else
      # TODO: : use refresh token here probably
      render json: { logged_in: false, message: 'no such user' }
    end
  end

  def destroy
    cookies[:token] = ''
    current_user = nil
    render json: { status: :ok, logged_out: true }
  end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
