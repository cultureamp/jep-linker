Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  devise_for :users
  root 'home#index'

  post "/", to: "home#create"

  namespace :api, defaults: { format: :json } do
    resources :links
  end
end
