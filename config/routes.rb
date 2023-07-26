Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

<<<<<<< HEAD
  resources :merchants, only: [:show] do
    resources :items, only: [:index], controller: "merchants/items"
    resources :invoices, only: [:index], controller: "merchants/invoices"
  end

#   get "/merchants/:id/items", to: "merchants/items#index"
#   get "merchants/:id/items/:id", to: "merchants/items#show"
=======
  get "/admin", to: "admin/application#welcome"
>>>>>>> 2c295ea0059190440a955e5b2a0039d7f08ca500
end
