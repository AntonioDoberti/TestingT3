require 'rails_helper'

RSpec.describe ShoppingCart, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: '1as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @shopping_cart = ShoppingCart.new(user_id: @user.id, products: {@product.id => 1})
    end 

    describe 'testing valid shopping cart' do
        it 'is valid with valid attributes' do
            expect(@shopping_cart).to be_valid
        end
    end
end


# test precio total
RSpec.describe ShoppingCart, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: '1as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @shopping_cart = ShoppingCart.new(user_id: @user.id, products: {@product.id => 1})
    end

    describe 'testing precio total' do
        it 'is valid with valid attributes' do
            expect(@shopping_cart.precio_total).to eq(4000)
        end
    end
end


# test costo envio
RSpec.describe ShoppingCart, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: '1as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @shopping_cart = ShoppingCart.new(user_id: @user.id, products: {@product.id => 1})
    end

    describe 'testing costo envio' do
        it 'is valid with valid attributes' do
            expect(@shopping_cart.costo_envio).to eq(1200)
        end
    end
end

#test no products
RSpec.describe ShoppingCart, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'as@gmail.com', role: 'admin')
        @shopping_cart = ShoppingCart.new(user_id: @user.id, products: {})
    end

    describe 'testing no products' do
        it 'is valid with valid attributes' do
            expect(@shopping_cart).to be_valid
        end
    end
end