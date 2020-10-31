# frozen_string_literal: true

# Controller for handling authentication
# Not sure we need this
class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    command = AuthenticateUser.call(params[:email], params[:password])

    if command.success?
      render json: { auth_token: command.result }
    else
      render json: { error: command.errors }, status: :unauthorized
    end
  end

  private

  def authentication_params
    params.require(:user).permit(:email, :password)
  end
end
