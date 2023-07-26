Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/admin", to: "admin/application#welcome"

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end
end
