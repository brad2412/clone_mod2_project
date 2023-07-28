Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :merchants, only: [:show] do
    resources :items, only: [:index], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
  end
  get "/merchants/:id/dashboard", to: "merchants#show"
  # get "/merchants/:id/invoices/:id", to: "merchants/invoices#show"

  get "/admin", to: "admin/application#welcome"

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show]
  end
end
