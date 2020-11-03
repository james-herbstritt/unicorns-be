# frozen_string_literal: true

# Controller for the application
class ApplicationController < ActionController::Base
  attr_accessor :current_user
  helper_attr :current_user
  skip_before_action :verify_authenticity_token
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
