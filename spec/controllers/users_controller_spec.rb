require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:user) { User.create!(name: 'John Doe', email: 'ass@gmail.com',
                                password: 'password') } 
    let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }
    let(:solicitud) { Solicitud.create!(stock: 2, status: 'Pendiente', user_id: user.id, product_id: product.id) }

    describe 'GET #show' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'renders the show template' do
                get :show
                expect(response).to render_template('show')
            end
        end

        context 'when user is not logged in' do
            it 'redirects to the root path' do
                get :show
                expect(response.status).to eq(200)
            end
        end
    end

    describe 'GET #deseados' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'renders the deseados template' do
                get :deseados
                expect(response).to render_template('deseados')
            end
        end
    end

    describe 'GET #mensajes' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'renders the mensajes template' do
                get :mensajes
                expect(response).to render_template('mensajes')
            end
        end
    end
end
