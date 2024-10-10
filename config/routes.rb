# frozen_string_literal: true

Rails.application.routes.draw do
  # ルートページを products#index に設定
  root 'products#index'

  # ActiveStorage の Blob ルート
  direct :rails_blob do |blob|
    route_for(:rails_blob, blob)
  end

  # Users のルーティング (edit, update のみ)
  resources :users, only: %i[edit update]

  # Tasks のルーティング (index, new のみ)
  resources :tasks, only: %i[index new]

  # Products のルーティング (index, show のみ)
  resources :products, only: %i[index show] do
    collection do
      get 'popular', to: 'products#popular', as: 'popular_products'
      get 'new', to: 'products#new_arrivals', as: 'new_products'
    end
  end

  # カートに商品を追加するルート
  post 'add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'

  # 静的ページの "About" へのルート
  get 'about', to: 'static_pages#about', as: 'about'

  # HomeController の index アクションへのルート
  get 'home/index'

  # 管理者用のルーティング
  namespace :admin do
    resources :products
  end
end
