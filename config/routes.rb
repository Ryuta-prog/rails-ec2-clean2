# frozen_string_literal: true

Rails.application.routes.draw do
  resources :products, only: %i[index show]

  resource :cart, only: [:show] do
    resources :cart_items, only: %i[create destroy]
  end

  root 'products#index'

  namespace :admin do
    root 'products#index'
    resources :products
  end
end
