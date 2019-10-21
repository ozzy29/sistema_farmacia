class Api::V1::CashiersController < Api::V1::MiddlewareController

  before_action :authorize_request, except: :register

  def verified
    puts("entro a verified")
  end

  def register
    @cashier = Cashier.create(cashier_params)
    begin
      if @cashier.valid?
        @cashier.save
        data = { id: @cashier.id, email: @cashier.email, dni: @cashier.dni }
        token = JsonWebToken.encode(data)
        if @cashier.update_attributes(token_jwt: token)
          render json: { token: @cashier.token_jwt, status: :ok }
        else
          render json: { erros: @user.errors.messages, status: :bad_request }
        end
      else
        render json: { errors: @cashier.errors.messages }, status: :bad_request
      end
    rescue JWT::EncodeError => e
      render json: { errors: e.messages }, status: :bad_request
    end
  end

  def cashier_params
    params.require(:cashier).permit(:first_name, :last_name, :email, :dni, :age, :birth_day, :password)
  end

end
