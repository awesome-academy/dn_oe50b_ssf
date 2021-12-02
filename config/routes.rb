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
    resources :static_pages, only: %i(index show)
    resources :account_activations, only: :edit
    resources :users
    resources :password_resets, only: %i(new create edit update)
    resources :comments, only: %i(create)

    namespace :admin do
      resources :soccer_fields, except: %i(show)
      get "/soccer_field_path/:id", to: "soccer_fields#destroy"
      resources :orders, only: %i(index update)
    end

    namespace :user do
      resources :orders, only: %i(index)
    end
  end
end
