class AuthenticationController < ApplicationController
    before_action :authorize_request, except: [:login, :signup]
  
    def login
      @user = User.find_by(email: login_params[:email])
      if @user&.authenticate(login_params[:password])
        token = encode_token({ user_id: @user.id, admin: @user.admin })
        render json: { token: token, user: @user }, status: :ok
      else
        render json: { error: 'Invalid email or password' }, status: :unauthorized
      end
    end
  
    def signup
      @user = User.new(user_params)
      if @user.save
        token = encode_token({ user_id: @user.id, admin: @user.admin })
        render json: { token: token, user: @user }, status: :created
      else
        render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def login_params
      params.permit(:email, :password)
    end
  
    def user_params
      params.permit(:email, :password, :password_confirmation, :admin)
    end
end
  