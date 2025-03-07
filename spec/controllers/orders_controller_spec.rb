# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) { Order.create(email: "test@example.com") }

  describe 'POST #create' do
    it 'returns http success' do
      post :create, params: { order: { email: "test@example.com" } }
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET #index' do
    it 'returns http success' do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET #show' do
    it 'returns http success' do
      get :show, params: { id: order.id }
      expect(response).to have_http_status(:success)
    end
  end
end
