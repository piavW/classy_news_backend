Rails.application.routes.draw do
  get 'articles/index'
  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index], constraints: { format: 'json' }
    end

    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
    end
  end
end