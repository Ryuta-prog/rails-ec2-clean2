# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :products, only: %i[index show]

  resource :cart, only: [:show] do
    resources :cart_items, only: %i[create destroy]
  end

  resources :orders, only: %i[create index show]

  resources :messages, only: %i[index new create] do
    collection do
      post 'confirm'
    end
  end
  get 'messages/done', to: 'messages#done', as: 'done_messages'

  root 'products#index'

  namespace :admin do
    get 'products/index'
    get 'products/show'
    get 'products/new'
    get 'products/edit'
    get 'products/create'
    get 'products/update'
    get 'products/destroy'
    root 'products#index'
    resources :products
    resources :orders, only: %i[index show]
  end
end
