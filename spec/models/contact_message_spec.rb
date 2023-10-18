require 'rails_helper'

RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing valid contact_message' do
        it 'is valid with valid attributes' do
            expect(@contact_message).to be_valid
        end
    end
end

#test no title
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: nil, body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing no title' do
        it 'is not valid with invalid title' do
            expect(@contact_message).not_to be_valid
        end
    end 
end

#test no body
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: nil,
                                            name: 'John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing no body' do
        it 'is not valid with invalid body' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test no name
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: nil, mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing no name' do
        it 'is not valid with invalid name' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test no mail
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: nil, phone: '+56912345678')
    end

    describe 'testing no mail' do
        it 'is not valid with invalid mail' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test no phone
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: nil)
    end

    describe 'testing no phone' do
        it 'is not valid with invalid phone' do
            expect(@contact_message).to be_valid
        end
    end
end

#test invalid phone format
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: '12345678')
    end

    describe 'testing invalid phone format' do
        it 'is not valid with invalid phone format' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test phone lenght > 20
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: '+569123456789123456789')
    end

    describe 'testing phone lenght > 20' do
        it 'is not valid with phone lenght > 20' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test title lenght > 50
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing title lenght > 50' do
        it 'is not valid with title lenght > 50' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test body lenght > 500
RSpec.describe ContactMessage, type: :model do
    before do
        @long = 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
        aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
        @contact_message = ContactMessage.new(title: 'John1', body: @long, name: 'John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing body lenght > 500' do
        it 'is not valid with body lenght > 500' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test name lenght > 50
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1John1', mail: 'as@gmail.com', phone: '+56912345678')
    end

    describe 'testing name lenght > 50' do
        it 'is not valid with name lenght > 50' do
            expect(@contact_message).not_to be_valid
        end
    end
end

#test mail lenght > 50
RSpec.describe ContactMessage, type: :model do
    before do
        @contact_message = ContactMessage.new(title: 'John1', body: 'Nonono123!',
                                            name: 'John1', mail: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaas@gmail.com',
                                             phone: '+56912345678')
    end

    describe 'testing mail lenght > 50' do
        it 'is not valid with mail lenght > 50' do
            expect(@contact_message).not_to be_valid
        end
    end
end