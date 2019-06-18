# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ProductForm, type: :model do

  subject { described_class.new(attributes) }

  describe 'create' do
    context 'with valid attributes' do
      let(:attributes) do
        {
          name: 'rice',
          category: 'food',
          price: 13.0
        }
      end

      it { is_expected.to be_valid }

      it 'creates the product' do
        expect {
          subject.create
        }.to change(Product, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) do
        {
          name: 'name',
          category: nil,
        }
      end

      it { is_expected.to_not be_valid }

      it 'does not creates the product' do
        expect {
          subject.create
        }.to_not change(Product, :count).from(0)
      end
    end
  end

  describe 'update' do
    let!(:product) { create(:product) }

    context 'with valid attributes' do
      let(:attributes) do
        {
          id: product.id,
          category: 'new',
          price: 15.0
        }
      end

      it { is_expected.to be_valid }

      it 'updates the product' do
        expect {
          subject.update
          product.reload
        }.to change(product, :updated_at)
      end
    end

    context 'with invalid attributes' do
      let(:attributes) do
        {
          id: product.id,
          category: nil,
        }
      end

      it { is_expected.to_not be_valid }

      it 'does not update the product' do
        expect {
          subject.update
          product.reload
        }.to_not change { product.category }
      end
    end
  end

  describe 'destroy' do
    let!(:product) { create(:product) }

    let(:attributes) do
      { id: product.id }
    end

    it 'deletes the product' do
      expect {
        subject.destroy
      }.to change { Product.exists?(product.id) }.from(true).to(false)
    end
  end
end