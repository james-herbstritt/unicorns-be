# frozen_string_literal: true

# Authorize a http request
class AuthorizeApiRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    user
  end

  private

  attr_reader :headers

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    @user ||= errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(auth_token)
  end

  def auth_token
    return parse_cookies['token'] if parse_cookies['token'].present?

    errors.add(:token, 'Missing token')
    nil
  end

  def parse_cookies
    cookies = {}
    cookies_string = headers[:Cookie].split(' ')
    cookies_string.each do |cookie|
      h = cookie.split('=')
      cookies[h[0]] = h[1]
    end
    cookies
  end
end
