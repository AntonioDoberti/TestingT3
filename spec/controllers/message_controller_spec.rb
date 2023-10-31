require 'rails_helper'

RSpec.describe MessageController, type: :controller do
  let(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user: user) }
  let(:valid_params) { { product_id: product.id, message: { body: 'Test message' } } }

  before do
    sign_in user
  end

    describe 'POST #insertar' do
        context 'with valid params' do
            it 'creates a new message' do
            expect {
                post :insertar, params: valid_params
            }.to change(Message, :count).by(1)
            expect(flash[:notice]).to eq('Pregunta creada correctamente!')
            expect(response).to redirect_to("/products/leer/#{product.id}")
            end
        end

        context 'with invalid params' do
            it 'does not create a new message' do
            expect {
                post :insertar, params: { product_id: product.id, message: { body: nil } }
            }.not_to change(Message, :count)
            expect(flash[:error]).to eq('Hubo un error al guardar la pregunta. ¡Completa todos los campos solicitados!')
            expect(response).to redirect_to("/products/leer/#{product.id}")
            end
        end
    end

    describe 'DELETE #eliminar' do
    let!(:message) { Message.create!(body: 'Test message', product: product, user: user) }

        it 'deletes the message' do
            expect {
            delete :eliminar, params: { product_id: product.id, message_id: message.id }
            }.to change(Message, :count).by(-1)
            expect(response).to redirect_to("/products/leer/#{product.id}")
            expect(Message.find_by(id: message.id)).to be_nil
        end
    end
end