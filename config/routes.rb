OptimHandel::Application.routes.draw do
  resources :categories

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :products
  resources :users, :only => :show

  namespace :admin do
    get '', to: 'dashboard#index', as: '/'
    resources :products
    resources :users
    resources :categories
  end
end
