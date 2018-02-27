Rails.application.routes.draw do

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  root "static_pages#home"

  resources :carts, only: [:index, :update, :destroy]
  resources :products, only: [:index, :show]

end
