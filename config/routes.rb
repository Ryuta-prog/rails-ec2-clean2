# frozen_string_literal: true

Rails.application.routes.draw do
  resource :cart, only: [:show] do
    resources :cart_items, only: %i[create destroy]
  end
  resources :orders, only: %i[create index show]

  root 'products#index'

  namespace :admin do
    root 'products#index'
    resources :products
  end
end
