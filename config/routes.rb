Rails.application.routes.draw do
  devise_for :users
  root 'links#new'

  post "/", to: "links#create"
  get "/links", to: "links#index"
  get "/:short_url", to: "links#redirect"
  resources :links

  namespace :api do
    get "/status", to: "status#check"
  end
end
