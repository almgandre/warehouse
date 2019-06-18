# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Products', type: :request do
  let!(:products) { create_list(:product, 5) }
  let(:first_product_id) { products.first.id }

  describe 'GET /products' do
    context 'without filter' do
      before { get products_path }

      it 'returns all products' do
        expect(json).not_to be_empty
        expect(json.size).to eq 5
      end

      it 'returns correct data' do
        expect(json.first).to include 'id'
        expect(json.first).to include 'name'
        expect(json.first).to include 'category'
        expect(json.first).to include 'price'
        expect(json.first).to include 'created_at'
        expect(json.first).to include 'updated_at'
      end
    end

    context 'with name filter' do
      let(:filter) do
        { name: products.second.name }
      end

      before { get products_path, params: filter }

      it 'returns only result' do
        expect(json).not_to be_empty
        expect(json.size).to eq 1
      end

      it 'returns correct product' do
        expect(json.first['id']).to eq products.second.id
      end
    end
  end

  describe 'GET /products/:id' do

    before { get product_path(product_id) }

    context 'when the record exists' do
      let(:product_id) { first_product_id }

      it 'returns the correct product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq first_product_id
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end
    end

    context 'when the record does not exist' do
      let(:product_id) { -1 }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Product/
      end
    end
  end

  describe 'POST /products' do
    let(:valid_attributes) do
      {
        name: 'rice',
        category: 'food',
        price: 13.0
      }
    end

    context 'when the request is valid' do
      before { post products_path, params: valid_attributes }

      it 'creates a product' do
        expect {
          post products_path, params: valid_attributes
        }.to change(Product, :count).by(1)
      end

      it 'creates product with correct information' do
        expect(json['name']).to eq 'rice'
        expect(json['category']).to eq 'food'
        expect(json['price']).to eq '13.0'
        expect(json['id']).to be_present
        expect(json['created_at']).to be_present
        expect(json['updated_at']).to be_present
      end

      it 'returns status code 201' do
        expect(response).to have_http_status 201
      end
    end

    context 'when the request is invalid' do
      before do
        post products_path, params: { name: 'name', category: 'category' }
      end

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body).to include "can't be blank"
      end
    end
  end

  describe 'PUT /products/:id' do
    let(:valid_attributes) do
      {
        category: 'new category',
        price: 12.0
      }
    end

    context 'when the record exists' do
      before { put product_path(first_product_id), params: valid_attributes }

      it 'updates the product' do
        product = products.first

        expect {
          put product_path(products.first.id), params: valid_attributes
          product.reload
        }.to change { product.category }.to('new category').
          and(change { product.price.to_f }.to(12.0))
      end

      it 'returns status code 200' do
        expect(response).to have_http_status 200
      end

      it 'returns the correct product' do
        expect(json).not_to be_empty
        expect(json['id']).to eq products.first.id
        expect(json['category']).to eq 'new category'
        expect(json['price']).to eq '12.0'
      end
    end

    context 'when the record does not exits' do
      before { put product_path(-1), params: valid_attributes }

      it 'returns status code 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match /Couldn't find Product/
      end
    end
  end

  describe 'DELETE /products/:id' do
    let(:delete_action) { delete product_path(first_product_id) }

    it 'deletes the product' do
      expect {
        delete_action
      }.to change { Product.exists?(first_product_id) }.from(true).to(false)
    end

    it 'returns status code 204' do
      delete_action

      expect(response).to have_http_status 204
    end
  end
end
