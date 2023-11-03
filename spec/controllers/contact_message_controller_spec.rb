
#crea test para el archivo contact_message_controller.rb
# Path: spec/controllers/contact_message_controller_spec.rb

require 'rails_helper'

RSpec.describe ContactMessageController, type: :controller do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'abc@gmail.com', role: 'admin')
        @contact_message = ContactMessage.create!(name: 'John1', mail: 'asd@gmail', title: 'Hola', body: 'Hola')
        @contact_message2 = ContactMessage.create!(name: 'John2', mail: 'asd@gmail', title: 'Hola2', body: 'Hola2')
        @ability = Ability.new(@user)
        @ability.can?(:manage, :all)
        sign_in @user
    end

    describe 'Post #index' do
        it 'returns a success response' do
            post :crear, params: { contact: { name: 'John1', mail: 'asd@gmail', title: 'Hola', body: 'Hola' } }
            expect(response).to redirect_to('/contacto')
            expect(flash[:notice]).to eq('Mensaje de contacto enviado correctamente')
        end
    end

    context 'Post #index caso alternativo' do
        it 'no crea un mensaje de contacto y muestra un mensaje de error' do
          post :crear, params: { contact: { name: 'John1', mail: 'asd@gmail', title: 'Hola', body: '' } }
          expect(response).to redirect_to('/contacto')
          expect(flash[:alert]).to include('Error al enviar el mensaje de contacto')
        end
      end

    describe 'GET #show' do
        it 'Shows descendent messages' do
            get :mostrar
            expect(response).to be_successful
            expect(assigns(:contact_messages)).to eq([@contact_message2, @contact_message])
        end
    end

    describe 'fail Get show' do
        it 'there are no messages' do
            ContactMessage.destroy_all
            get :mostrar
            expect(response).to be_successful
            expect(assigns(:contact_messages)).to eq([])
        end
    end

    describe 'DELETE limpiar' do
        it 'returns a success response' do
            delete :eliminar, params: { id: @contact_message.id }
            delete :eliminar, params: { id: @contact_message2.id }
            expect(response).to redirect_to('/contacto')
            expect(flash[:notice]).to eq('Mensaje de contacto eliminado correctamente')
        end
    end

    describe 'DELETE limpiar caso alternativo' do
        it 'returns error' do
            delete :eliminar, params: { id: 0 }
            expect(response).to redirect_to('/contacto')
            expect(flash[:alert]).to eq('Error al eliminar el mensaje de contacto')
        end
    end

    describe 'DELETE #limpiar' do
        it 'returns a success response' do
            delete :limpiar
            expect(response).to redirect_to('/contacto')
        end
    end
end



#Usuario no es admin
RSpec.describe ContactMessageController, type: :controller do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'abc@gmail.com', role: 'user')
        @contact_message = ContactMessage.create!(name: 'John1', mail: 'asd@gmail', title: 'Hola', body: 'Hola')
        @contact_message2 = ContactMessage.create!(name: 'John2', mail: 'asd@gmail', title: 'Hola2', body: 'Hola2')
        @ability = Ability.new(@user)
        @ability.cannot?(:manage, :all)
        sign_in @user
    end

    describe 'Limpiar, no es admin' do
        it 'returns a success response' do
            delete :limpiar
            expect(response).to redirect_to('/contacto')
            expect(flash[:alert]).to eq('Debes ser un administrador para eliminar los mensajes de contacto.')
        end
    end
end