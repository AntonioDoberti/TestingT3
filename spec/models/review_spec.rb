require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asdf@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: 'John1', calification: 1, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing valid review' do
    it 'is valid with valid attributes' do
      expect(@review).to be_valid
    end
  end
end

# test no title
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asd@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: nil, description: 'John1', calification: 1, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing no title' do
    it 'is not valid with invalid title' do
      expect(@review).not_to be_valid
    end
  end
end

# test title longer than 100
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asd@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(
      tittle: 'John1John1John1John1John1John1John1John1John1John1John1
      John1John1John1John1John1John1John1John1John1John1', description: 'John1', calification: 1,
      product_id: @product.id, user_id: @user.id
    )
  end

  describe 'testing title longer than 100' do
    it 'is not valid with invalid title' do
      expect(@review).not_to be_valid
    end
  end
end

# test no description
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asdf@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: nil, calification: 1, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing no description' do
    it 'is not valid with invalid description' do
      expect(@review).not_to be_valid
    end
  end
end

# description longer than 500
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asdf@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @longer = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
    aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
    @review = Review.new(tittle: 'John1', description: @longer, calification: 1, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing description longer than 500' do
    it 'is not valid with invalid description' do
      expect(@review).not_to be_valid
    end
  end
end

# test no calification
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asdf@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: 'John1', calification: nil, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing no calification' do
    it 'is not valid with invalid calification' do
      expect(@review).not_to be_valid
    end
  end
end

# test calification not integer
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asd@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: 'John1', calification: 1.5, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing calification not integer' do
    it 'is not valid with invalid calification' do
      expect(@review).not_to be_valid
    end
  end
end

# test calification less than 1
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asd@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: 'John1', calification: 0, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'testing calification less than 1' do
    it 'is not valid with invalid calification' do
      expect(@review).not_to be_valid
    end
  end
end

# test calification greater than 5
RSpec.describe Review, type: :model do
  before do
    @user = User.create!(name: 'John1', password: 'Nonono123!',
                         email: 'asd@gmail.com', role: 'admin')
    @product = Product.create!(nombre: 'John1', precio: 4000, stock: 1, user_id: @user.id, categories: 'Cancha')
    @review = Review.new(tittle: 'John1', description: 'John1', calification: 6, product_id: @product.id,
                         user_id: @user.id)
  end

  describe 'reviewtesting calification greater than 5' do
    it 'is not valid with invalid calification' do
      expect(@review).not_to be_valid
    end
  end
end
