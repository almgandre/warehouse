# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProductFilter, type: :model do
  describe '.filter' do
    let(:fruit_product) { create(:product, name: 'apple') }
    let(:other_product) { create(:product, name: 'tool') }

    subject { described_class.new(name: 'apple').filter }

    it { is_expected.to eq [fruit_product] }
  end
end
