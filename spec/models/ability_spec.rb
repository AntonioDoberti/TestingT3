require 'rails_helper'

RSpec.describe Ability, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @review = Review.create!(tittle: 'John1', description: 'Nonono123!', calification: 5, user_id: @user.id, product_id: @product.id)
        @message = Message.create!(body: 'John1', user_id: @user.id, product_id: @product.id)
        @solicitud = Solicitud.create!(stock: 1, status: 'Pendiente', user_id: @user.id, product_id: @product.id)
        @ability = Ability.new(@user)
    end

    describe 'testing admin' do
        it 'is valid with valid attributes' do
            expect(@ability.can?(:manage, :all)).to eq(true)
        end
    end
end

RSpec.describe Ability, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @review = Review.create!(tittle: 'John1', description: 'Nonono123!', calification: 5, user_id: @user.id, product_id: @product.id)
        @message = Message.create!(body: 'John1', user_id: @user.id, product_id: @product.id)
        @solicitud = Solicitud.create!(stock: 1, status: 'Pendiente', user_id: @user.id, product_id: @product.id)
        @ability = Ability.new(@user)
    end

    describe 'testing user' do
        it 'is valid with valid attributes' do
            expect(@ability.can?(:index, Product)).to eq(true)
            expect(@ability.can?(:leer, Product)).to eq(true)
            expect(@ability.can?(:insertar, Product)).to eq(true)
            expect(@ability.can?(:crear, Product)).to eq(true)
            expect(@ability.can?(:index, Review)).to eq(true)
            expect(@ability.can?(:leer, Review)).to eq(true)
            expect(@ability.can?(:insertar, Review)).to eq(true)
            expect(@ability.can?(:crear, Review)).to eq(true)
            expect(@ability.can?(:leer, Message)).to eq(true)
            expect(@ability.can?(:insertar, Message)).to eq(true)
            expect(@ability.can?(:index, Solicitud)).to eq(true)
            expect(@ability.can?(:insert_deseado, Product)).to eq(true)
            expect(@ability.can?(:insertar, Solicitud)).to eq(true)
            expect(@ability.can?(:eliminar, Solicitud)).to eq(true)
            expect(@ability.can?(:leer, Solicitud)).to eq(true)
            expect(@ability.can?(:eliminar, Product)).to eq(true)
            expect(@ability.can?(:actualizar_producto, Product)).to eq(true)
            expect(@ability.can?(:actualizar, Product)).to eq(true)
            expect(@ability.can?(:eliminar, Review)).to eq(true)
            expect(@ability.can?(:actualizar_review, Review)).to eq(true)
            expect(@ability.can?(:actualizar, Review)).to eq(true)
            expect(@ability.can?(:eliminar, Message)).to eq(true)
        end
    end
end

RSpec.describe Ability, type: :model do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'as@gmail.com', role: 'admin')
        @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
        @review = Review.create!(tittle: 'John1', description: 'Nonono123!', calification: 5, user_id: @user.id, product_id: @product.id)
        @message = Message.create!(body: 'John1', user_id: @user.id, product_id: @product.id)
        @solicitud = Solicitud.create!(stock: 1, status: 'Pendiente', user_id: @user.id, product_id: @product.id)
        @ability = Ability.new(nil)
    end

    describe 'testing nil' do
        it 'is valid with valid attributes' do
            expect(@ability.can?(:index, Product)).to eq(true)
            expect(@ability.can?(:leer, Product)).to eq(true)
            expect(@ability.can?(:index, Review)).to eq(true)
            expect(@ability.can?(:leer, Review)).to eq(true)
            expect(@ability.can?(:leer, Message)).to eq(true)
        end
    end
end


