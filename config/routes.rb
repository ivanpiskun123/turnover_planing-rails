Rails.application.routes.draw do

  get 'pages/home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  root to: "pages#home"


  match '*path' => redirect('/'), via: :get

end
