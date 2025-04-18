# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :products, only: %i[index show]

  resource :cart, only: %i[show update] do
    patch 'apply_promotion_code', on: :member
    resources :cart_items, only: %i[create destroy]
  end

  resources :cart_items, only: %i[create destroy]
  patch '/apply_promotion_code', to: 'carts#apply_promotion_code', as: :apply_promotion_code

  resources :orders, only: %i[create index show]

  root 'products#index'

  namespace :admin do
    root 'products#index'
    resources :products
    resources :orders, only: %i[index show]
  end
end
