EShop::Application.routes.draw do
  root to: 'store#index', via: :get
  devise_for :users, controllers: { registrations: :account }
  devise_scope :user do
    resource :account, controller: :account do
    end
  end

  resources :users
  resources :addresses
  resources :categories
  resources :orders
  resources :carts
  resources :line_items
  resources :shipments

  resource :store,  only: [:index] do
    resources :products, controller: :store, only: [:index, :show] do
    end
  end

  resources :products do
    collection { get :search, to: 'products#index' }
  end
end
