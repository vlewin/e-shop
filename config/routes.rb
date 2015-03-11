EShop::Application.routes.draw do
  root to: 'store#index', via: :get
  devise_for :users, controllers: { registrations: :registrations, sessions: :sessions, invitations: :invitations }

  resources :users
  resources :categories
  resources :line_items
  resources :shipments
  resources :payments
  resource :account, controller: :account, only: [:show]

  resources :addresses do
    member do
      delete :delete
    end
  end

  resources :orders do
    member do
      put :update_status
    end
  end

  resources :carts do
    member do
      put :update_shipment
    end

    collection do
      delete :purge
    end
  end

  resource :store,  only: [:index] do
    resources :products, controller: :store, only: [:index, :show] do
    end
  end

  resources :products do
    collection { get :search, to: 'products#index' }
  end

  # Handle non-existing routes
  get '*path', to: 'application#not_found'
end
