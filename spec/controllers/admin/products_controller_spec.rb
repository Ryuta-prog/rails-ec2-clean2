# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  # テスト用のデータを準備
  let(:product) { Product.create(name: "テスト商品", description: "これはテスト商品です", price: 100) }

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #new' do
    it 'returns http success' do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #edit' do
    it 'returns http success' do
      get :edit, params: { id: product.id }
      expect(response).to have_http_status(:success)
    end
  end
  describe 'POST #create' do
  it 'returns redirect status' do
    post :create, params: { product: { name: "新商品", description: "新しい商品です", price: 200 } }
    expect(response).to have_http_status(:redirect)
  end

  it 'redirects to admin products path' do
    post :create, params: { product: { name: "新商品", description: "新しい商品です", price: 200 } }
    expect(response).to redirect_to(admin_products_path)
  end
end

  describe 'PATCH #update' do
    it 'returns redirect status' do
    patch :update, params: { id: product.id, product: { name: "更新商品", description: "更新された商品です" } }
    expect(response).to have_http_status(:redirect)
  end

    it 'redirects to admin products path' do
    patch :update, params: { id: product.id, product: { name: "更新商品", description: "更新された商品です" } }
    expect(response).to redirect_to(admin_products_path)
  end
  end

  describe 'DELETE #destroy' do
    it 'returns redirect status' do
    delete :destroy, params: { id: product.id }
    expect(response).to have_http_status(:redirect)
  end

    it 'redirects to admin products path' do
    delete :destroy, params: { id: product.id }
    expect(response).to redirect_to(admin_products_path)
  end
  end

end
