Rails.application.routes.draw do
  get 'about/basic'

  devise_for :users
  root 'links#index'
  resources :links, path: ""
  post "/", to: "links#create"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    get "/status", to: "status#alive"
    get "/about", to: "about#basic"
    post "/user/:id", to: "status#show"
    get "/links", to: "links#index"
  end
end
