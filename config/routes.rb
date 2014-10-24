EShop::Application.routes.draw do
  root to: 'store#index', via: :get
  devise_for :users, controllers: { registrations: :account, sessions: :sessions }
  devise_scope :user do
    resource :account, controller: :account do
    end
  end

  resources :users
  resources :addresses
  resources :categories
  resources :line_items
  resources :shipments

  resources :orders do
    member do
      put :update_status
    end
  end

  resources :carts do
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
