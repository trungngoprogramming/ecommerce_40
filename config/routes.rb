Rails.application.routes.draw do

  root "static_pages#home"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  patch "/plus/:id", to: "cart_items#plus", as: :plus
  patch "/minus/:id", to: "cart_items#minus", as: :minus

  resources :carts, only: [:index, :update, :destroy]
  resources :products, only: [:index, :show]

end
