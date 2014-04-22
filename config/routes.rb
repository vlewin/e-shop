OptimHandel::Application.routes.draw do
  resources :addresses

  root to: 'store#index', via: [:get, :post]

  scope '(:locale)', locale: /en|de/ do
    devise_for :users, controllers: { registrations: 'registrations' }
    resources :orders
    resources :carts
    resources :line_items
    resources :categories
    resources :users

    resources :products do
      collection { get :search, to: 'products#index' }
    end
  end
end
