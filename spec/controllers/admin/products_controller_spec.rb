# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
  let!(:product) { Product.create(name: 'テスト商品', description: 'これはテスト商品です', price: 100) }

  describe 'GET #index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'renders the show template' do
      get :show, params: { id: product.id }
      expect(response).to render_template(:show)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new product' do
        expect do
          post :create, params: { product: { name: '新商品', description: '新しい商品です', price: 200 } }
        end.to change(Product, :count).by(1)
      end

      it 'redirects to admin products path after creation' do
        post :create, params: { product: { name: '新商品', description: '新しい商品です', price: 200 } }
        expect(response).to redirect_to(admin_products_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not create a product' do
        expect do
          post :create, params: { product: { name: '', description: '説明', price: 200 } }
        end.not_to change(Product, :count)
      end

      it 're-renders the new template on failure' do
        post :create, params: { product: { name: '', description: '説明', price: 200 } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'updates the product' do
        patch :update, params: { id: product.id, product: { name: '更新商品' } }
        expect(product.reload.name).to eq('更新商品')
      end

      it 'redirects to admin products path after update' do
        patch :update, params: { id: product.id, product: { name: '更新商品' } }
        expect(response).to redirect_to(admin_products_path)
      end
    end

    context 'with invalid attributes' do
      it 'does not update the product' do
        patch :update, params: { id: product.id, product: { name: '' } }
        expect(product.reload.name).to eq('テスト商品')
      end

      it 're-renders the edit template on failure' do
        patch :update, params: { id: product.id, product: { name: '' } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the product' do
      expect do
        delete :destroy, params: { id: product.id }
      end.to change(Product, :count).by(-1)
    end

    it 'redirects to admin products path after deletion' do
      delete :destroy, params: { id: product.id }
      expect(response).to redirect_to(admin_products_path)
    end
  end
end
