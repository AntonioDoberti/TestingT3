require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @message = Message.new(body: 'John1', user_id: @user.id, product_id: @product.id)
  end

  describe 'testing valid message' do
    it 'is valid with valid attributes' do
      expect(@message).to be_valid
    end
  end
end

# test no body
RSpec.describe Message, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @message = Message.new(body: nil, user_id: @user.id, product_id: @product.id)
  end

  describe 'testing no body' do
    it 'is not valid with invalid body' do
      expect(@message).not_to be_valid
    end
  end
end

# test no user_id
RSpec.describe Message, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @message = Message.new(body: 'John1', user_id: nil, product_id: @product.id)
  end

  describe 'testing no user_id' do
    it 'is not valid with invalid user_id' do
      expect(@message).not_to be_valid
    end
  end
end

# test no product_id
RSpec.describe Message, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'as@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @message = Message.new(body: 'John1', user_id: @user.id, product_id: nil)
  end

  describe 'testing no product_id' do
    it 'is not valid with invalid product_id' do
      expect(@message).not_to be_valid
    end
  end
end
