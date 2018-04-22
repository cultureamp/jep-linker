Rails.application.routes.draw do
  devise_for :users
  root 'home#index'

  post "/", to: "home#create"

  namespace :api, defaults: { format: :json } do
    resources :links
  end
end
