class Api::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      # Generate JWT token
      token = generate_token(user.id)

      render json: { user_id: user.id, token: token, message: 'Login successful' }
    else
      render json: { error: 'Invalid Email or Password' }, status: :unauthorized
    end
  end

  def destroy
    render json: { message: 'Logged Out' }
  end

  private

  def generate_token(user_id)
    payload = { user_id: user_id }
    secret_key = Rails.application.secret_key_base

    JWT.encode(payload, secret_key, 'HS256')
  end
end
