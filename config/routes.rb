OptimHandel::Application.routes.draw do
  resources :delivery_services

  root to: 'store#index', via: :get

  scope '(:locale)', locale: /en|de/ do
    devise_for :users, controllers: { registrations: 'registrations' }
    resources :users
    resources :addresses
    resources :categories
    resources :orders
    resources :carts
    resources :line_items

    resource :store,  only: [:index] do
      # get :index, to: 'store#index'
      # collection { get :search, to: 'store#index' }
      resources :products, controller: :store, only: [:index, :show] do
        # collection { get :search, to: 'products#index' }
      end

      # get :search, to: 'products#index'

      # resources :categories, only: [:index] do
      #   collection { get :search, to: 'products#index' }
      # end
    end

    resources :products do
      collection { get :search, to: 'products#index' }
    end
  end
end
