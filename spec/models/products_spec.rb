# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
  end

  it 'is valid with valid attributes' do
    expect(@product).to be_valid
  end
end

RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                         role: 'admin')
    @product = Product.new(nombre: nil, precio: 4000, stock: -1, user_id: @user.id, categories: 'Cancha')
  end

  it 'is not valid with invalid name' do
    # Esperamos que el producto no sea válido
    expect(@product).not_to be_valid
  end
end

#test precio menor a 0
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: -1, stock: 1, user_id: @user.id, categories: 'Cancha')
  end

  it 'is not valid with invalid price' do
    # Esperamos que el producto no sea válido
    expect(@product).not_to be_valid
  end
end

#test precio igual a 0
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 0, stock: 1, user_id: @user.id, categories: 'Cancha')
  end
  describe 'testing price = 0' do
    it 'is valid with price equal to 0' do
      # Esperamos que el producto sea válido
      expect(@product).to be_valid
    end
  end
end

#test stock menor a 0
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 10, stock: -1, user_id: @user.id, categories: 'Cancha')
  end

  it 'is not valid with invalid stock' do
    # Esperamos que el producto no sea válido
    expect(@product).not_to be_valid
  end
end

#test stock igual a 0
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 10, stock: 0, user_id: @user.id, categories: 'Cancha')

  end

  it 'is valid with stock equal to 0' do
    # Esperamos que el producto sea válido
    expect(@product).to be_valid
  end
end

#test categories vacio
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 10, stock: 1, user_id: @user.id, categories: '')
  end
  describe 'testing categories empty' do
    it 'is not valid with empty categories' do
      # Esperamos que el producto no sea válido
      expect(@product).not_to be_valid
    end
  end
end


#test categories invalida
RSpec.describe Product, type: :model do
  before(:each) do
    @user = User.create!(name: 'John1', password: 'Nonono123!', email: 'asdf@gmail.com',
                        role: 'admin')
    @product = Product.new(nombre: 'John1', precio: 10, stock: 1, user_id: @user.id, categories: 'Canchaz')
  end
  describe 'testing categories invalid' do
    it 'is valid with invalid categories' do
      # Esperamos que el producto sea válido
      expect(@product).not_to be_valid
    end
  end
end