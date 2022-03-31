require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Resque::Server.new, at: "/resque"
  devise_for :users
  root to: 'home#index'
  resources :sites, only: [:show, :new, :create, :destroy, :index]
end
