Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "/home", to: "static_pages#home"
    get "/order", to: "static_pages#order"
    get "/detail", to: "static_pages#detail"
  end
end
