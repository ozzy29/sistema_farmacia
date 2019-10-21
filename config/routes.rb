Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      # post 'user/register', to: 'users#register
      post 'cashier/register', to: 'cashiers#register'
      get 'cashier/verified', to: 'cashiers#verified'

      post 'auth/login', to: 'authentication#login'
      # post 'auth/authorize_request', to: 'middleware#authorize_request'
    end
  end

end
