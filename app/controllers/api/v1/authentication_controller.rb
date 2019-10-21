class Api::V1::AuthenticationController < ActionController::API

  def login

    begin
      @cashier = Cashier.find_by_email(params[:email])
      if @cashier&.authenticate(params[:password])
        if @cashier.token_jwt
          render json: { token: @cashier.token_jwt }, status: :ok
        else
          @cashier.password = params[:password]
          data_token = { id: @cashier.id, email: @cashier.email, dni: @cashier.dni }
          token = JsonWebToken.encode(data_token)
          if @cashier.update_attributes(token_jwt: token)
            render json: { token: @cashier.token_jwt }, status: :ok
          else
            render json: { erros: @cashier.errors.messages }, status: :bad_request
          end
        end
      else
        render json: { errors: 'Validar Email Y/O Clave' }, status: :unauthorized
      end
    rescue JWT::EncodeError => e
      render json: { errors: e.message }, status: :bad_request
    end

  end

  def login_params
    params.permit(:email, :password)
  end

end
