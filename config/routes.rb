Rails.application.routes.draw do
  root to: 'home#index'
  resources :sites, only: [:show, :new, :create]
end
