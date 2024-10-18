# frozen_string_literal: true

Rails.application.routes.draw do
  # ルートページを products#index に設定
  root 'products#index'

  # Products のルーティング (index, show のみ)
  resources :products, only: %i[index show]

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
