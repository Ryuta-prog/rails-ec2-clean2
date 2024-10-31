# frozen_string_literal: true

Rails.application.routes.draw do
  root 'products#index'

  direct :rails_blob do |blob|
    route_for(:rails_blob, blob)
  end

  resources :users, only: %i[edit update]
  resources :tasks, only: %i[index new]
  resources :products, only: %i[index show]

  post 'add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'home/index'
  
  namespace :admin do
    resources :products
  end
end
