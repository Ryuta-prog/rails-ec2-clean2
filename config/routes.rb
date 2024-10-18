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
  resources :products, only: %i[index show]

  # カートに商品を追加するルート
  post 'add_to_cart/:id', to: 'carts#add_to_cart', as: 'add_to_cart'

  Rails.application.routes.draw do
    resources :users, only: %i[edit update] # editとupdateアクションだけを有効にする
    # 他のルーティング...

    resources :tasks, only: %i[index new]

    # 静的ページの "About" へのルート
    get 'about', to: 'static_pages#about', as: 'about'

    # HomeController の index アクションへのルート
    get 'home/index'
  end

  # 管理者用
  Rails.application.routes.draw do
    namespace :admin do
      resources :products
    end
  end
end
