require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    let(:user) { User.create!(name: 'John Doe', email: 'ass@gmail.com',
                                password: 'password') } 
    let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }
    let(:solicitud) { Solicitud.create!(stock: 2, status: 'Pendiente', user_id: user.id, product_id: product.id) }
    let(:deseado) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }
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

    describe 'POST #actualizar_imagen' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'updates the user image' do
                image = fixture_file_upload('img/Lenna-1.png', 'image/png')
                post :actualizar_imagen, params: { image: image}
                expect(flash[:notice]).to eq('Imagen actualizada correctamente')
            end
        end
    end

    describe ' Hubo un error al actualizar la imagen. Verifique que la imagen es de formato jpg, jpeg, png, gif o webp' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'updates the user image' do
                image = fixture_file_upload('img/Lenna-1.png', 'image/pdf')
                allow_any_instance_of(User).to receive(:save).and_return(false)
                post :actualizar_imagen , params: { image: image}
                expect(flash[:error]).to eq('Hubo un error al actualizar la imagen. Verifique que la imagen es de formato jpg, jpeg, png, gif o webp')
            end
        end
    end

end
