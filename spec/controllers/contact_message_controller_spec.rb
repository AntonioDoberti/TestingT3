
#crea test para el archivo contact_message_controller.rb
# Path: spec/controllers/contact_message_controller_spec.rb

require 'rails_helper'

RSpec.describe ContactMessageController, type: :controller do
    before do
        @user = User.create!(name: 'John1', password: 'Nonono123!',
                             email: 'abc@gmail.com', role: 'admin')
        @contact_message = ContactMessage.create!(name: 'John1', mail: 'asd@gmail', title: 'Hola', body: 'Hola')
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

    # describe 'GET #show' do
    #     it 'returns a success response' do
    #         get :show, params: { name: @contact_message.name }
    #         expect(response).to be_successful
    #     end
    # end

    describe 'DELETE #eliminar' do
        it 'returns a success response' do
            delete :eliminar, params: { id: @contact_message.id }
            expect(response).to redirect_to('/contacto')
        end
    end

    describe 'DELETE #limpiar' do
        it 'returns a success response' do
            delete :limpiar
            expect(response).to redirect_to('/contacto')
        end
    end
end
