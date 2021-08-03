Rails.application.routes.draw do

  root to: "api/v1/pages#home"

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"



  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  namespace :api do
    namespace :v1 do
      get 'pages/home'

      get 'pages/dynamic-plan-execution'
      get 'pages/dynamic-indexed-sales'
      get 'pages/product-group-structure'
      get 'pages/payment-method-sctructure'
      get 'pages/trade-form-sctructure'
      get 'pages/seasonality'
      get 'pages/average-prices'

    end
  end




  match '*path' => redirect('/'), via: :get

end
