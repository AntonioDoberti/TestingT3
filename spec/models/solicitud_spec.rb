require 'rails_helper'

RSpec.describe Solicitud, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    #add a date to the reservation
    @solicitud = Solicitud.new(stock: 1, status: 'Pendiente', user_id: @user.id, product_id: @product.id)
    
  end

  describe 'testing valid solicitud' do
    it 'is valid with valid attributes' do
      expect(@solicitud).to be_valid
    end
  end
end

# test no stock
RSpec.describe Solicitud, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @solicitud = Solicitud.new(stock: nil, status: 'Pendiente', user_id: @user.id, product_id: @product.id)
  end

  describe 'testing no stock' do
    it 'is not valid with invalid stock' do
      expect(@solicitud).not_to be_valid
    end
  end
end

# test no status
RSpec.describe Solicitud, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @solicitud = Solicitud.new(stock: 1, status: nil, user_id: @user.id, product_id: @product.id)
  end

  describe 'testing no status' do
    it 'is not valid with invalid status' do
      expect(@solicitud).not_to be_valid
    end
  end
end
