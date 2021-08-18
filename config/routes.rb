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
          get 'years/:id', to: 'pages#index'
          get 'years/:id/dynamic-plan-execution', to: 'pages#dynamic_plan_execution'
          get 'years/:id/dynamic-indexed-sales', to: 'pages#dynamic_indexed_sales'
          get 'years/:id/product-group-structure', to: 'pages#product_group_structure'
          get 'years/:id/payment-method-sctructure', to: 'pages#payment_method_sctructure'
          get 'years/:id/trade-form-sctructure', to: 'pages#trade_form_sctructure'
          get 'years/:id/seasonality-sctructure', to: 'pages#seasonality'
          get 'years/:id/average-prices', to: 'pages#average_prices'
          get 'years/:id/abc-product-analysis', to: 'pages#abs_product_analysis'
    end
  end





  match '*path' => redirect('/'), via: :get

end
