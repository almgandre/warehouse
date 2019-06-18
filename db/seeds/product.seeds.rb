# frozen_string_literal: true

puts '-> Product seeds'
n = 10
n.times do
  Product.create!(
    name: Faker::Commerce.product_name,
    category: Faker::Commerce.department(2),
    price: Faker::Commerce.price
  )
end

puts "#{n} products created"