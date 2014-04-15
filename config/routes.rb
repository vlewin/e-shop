OptimHandel::Application.routes.draw do
  resources :addresses

  root to: 'home#index' #, as: 'store', via: :all
  get 'language', to: 'home#language'

  scope '(:locale)', locale: /en|de/ do
    devise_for :users, controllers: { registrations: 'registrations' }
    resources :orders
    resources :carts
    resources :line_items
    resources :categories
    resources :products
    resources :users
  end
end
