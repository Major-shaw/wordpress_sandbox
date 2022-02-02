Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :sites, only: [:show, :new, :create]
end
