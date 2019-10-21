class Api::V1::MiddlewareController < ActionController::API

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = Cashier.find(@decoded[:id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { errors: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { errors: e.message }, status: :bad_request
    rescue JWT::VerificationError
      render json: { errors: 'token invalid' }, status: :unauthorized
    end
  end

end
