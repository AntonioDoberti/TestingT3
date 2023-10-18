require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'John1', password: 'Nonono123!',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing valid user' do
    it 'is valid with valid attributes' do
      expect(@user).to be_valid
    end
  end
end

# test no name
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: nil, password: 'Nonono123!',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing no name' do
    it 'is not valid with invalid name' do
      expect(@user).not_to be_valid
    end
  end
end

# test name < 2
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'a', password: 'Nonono123!',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing name < 2' do
    it 'is not valid with invalid name' do
      expect(@user).not_to be_valid
    end
  end
end

# test name > 20
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa', password: 'Nonono123!',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing name > 20' do
    it 'is not valid with invalid name' do
      expect(@user).not_to be_valid
    end
  end
end

# test no presence email
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'John1', password: 'Nonono123!',
                     email: nil, role: 'admin')
  end

  describe 'testing no mail' do
    it 'is valid with valid attributes' do
      expect(@user).not_to be_valid
    end
  end
end

# test password_required?
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'John1', password: nil,
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing password_required?' do
    it 'is valid with valid attributes' do
      expect(@user.password_required?).to eq(true)
    end
  end
end

# test validate_password_strength
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'John1', password: '123',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing validate_password_strength, expected error' do
    it 'is valid with valid attributes' do
      @user.validate_password_strength
      expect(@user.errors[:password]).to include(
        'no es válido incluir como minimo una mayuscula, minuscula y un simbolo'
      )
    end
  end
end

# def validate_new_wish_product
RSpec.describe User, type: :model do
  before do
    @user = User.new(name: 'John1', password: 'Nonono123!',
                     email: 'as@gmail.com', role: 'admin')
  end

  describe 'testing validate_new_wish_product' do
    it 'is valid with valid attributes' do
      @user.validate_new_wish_product
      expect(@user.errors[:wish_product]).to include
    end
  end
end
