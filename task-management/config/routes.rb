Rails.application.routes.draw do
  root 'home#index'
  get '/about',   to: 'home#index'

  namespace :api do
    namespace :v1, format: 'json' do
      resources :tasks, only: [:index, :create, :update, :destroy] 
    end
  end
end
