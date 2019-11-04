Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index, :create, :update], constraints: { format: 'json' }
      resources :subscriptions, only: [:create, :index]
    end
  end

  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]
end