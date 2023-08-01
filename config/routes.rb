Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  
  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants, only: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
    resources :invoice_items, only: [:update], controller: "merchants/invoice_items"
  end

  get "/merchants/:id/dashboard", to: "merchants#show"
  
  get "/admin", to: "admin/application#welcome"
end