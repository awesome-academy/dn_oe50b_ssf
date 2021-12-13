Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#index"
    get "/home", to: "static_pages#index"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    get "pages/search", to: "pages#search", as: "search_page"
    resources :account_activations, only: :edit
    resources :users
    resources :carts
    resources :password_resets, only: %i(new create edit update)
    resources :static_pages, only: %i(index show)
    resources :carts
    resources :comments, only: %i(create)
    namespace :admin do
      get "/soccer_field_path/:id", to: "soccer_fields#destroy"
      get "search_revenue", to: "revenues#search_revenue"
      resources :soccer_fields, except: %i(show)
      resources :orders, only: %i(index update)
      resources :revenues, only: :index
    end
    namespace :user do
      resources :orders
      resources :order_details, only: :destroy
      get "order_soccer_field", to: "orders#order_soccer_field"
    end
  end
end
