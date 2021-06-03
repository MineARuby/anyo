Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :parameters, only: [:index, :create]
  resources :languages, only: :update
  resources :playpages, only: [:index, :create]
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :depthevals, only: :index
    end
  end
      # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
