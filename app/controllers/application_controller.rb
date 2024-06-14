class ApplicationController < ActionController::API
    def encode_token(payload)
        JsonWebToken.encode(payload)
      end
    
      def authorize_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        decoded = JsonWebToken.decode(header)
        @current_user = User.find(decoded[:user_id]) if decoded
      rescue
        render json: { errors: 'Unauthorized' }, status: :unauthorized
      end
end
