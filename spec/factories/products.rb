# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    name { Faker::Commerce.product_name }
    category { Faker::Commerce.department(2) }
    price { Faker::Commerce.price }
  end
end