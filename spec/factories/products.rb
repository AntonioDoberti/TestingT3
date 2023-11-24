FactoryBot.define do
  factory :product do
    nombre { Faker::Commerce.product_name }
    precio { Faker::Commerce.price }
    stock { Faker::Number.number(digits: 2) }
    categories { 'Cancha' }
  end
end
