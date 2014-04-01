OptimHandel::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :categories
  resources :products
  resources :users
end
