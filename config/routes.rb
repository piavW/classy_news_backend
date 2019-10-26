Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  get 'articles/index'
  namespace :api do
    namespace :v1 do
      resources :articles, only: [:index], constraints: { format: 'json' }
    end
  end
end