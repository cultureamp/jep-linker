Rails.application.routes.draw do
  devise_for :users
  root "links#new"
  resources :links
  get "/:short_url", to: "links#forward"

  namespace :api do
    get "/status", to: "status#check"
  end
end
