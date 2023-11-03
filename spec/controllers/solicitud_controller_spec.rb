require 'rails_helper'


RSpec.describe SolicitudController, type: :controller do
    let(:user) { User.create!(name: 'John Doe', email: 'ASS@gmail.com', password: 'password') }
    let(:product) do
        Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id)
        end
    let(:solicitud) do
        Solicitud.create!(stock: 2, status: 'Pendiente', user_id: user.id, product_id: product.id)
        end

    describe 'GET #index' do
        context 'when user is logged in' do
            before do
                sign_in user
            end

            it 'renders the index template' do
                get :index
                expect(response).to render_template('index')
            end
        

        context 'when user is not logged in' do
            it 'redirects to the root path' do
                get :index
                expect(response.status).to eq(200)
            end
        end
    end
    end

    describe 'POST #insertar' do
        context 'no stock to make solicitud' do
            before do
                sign_in user
            end

            it 'redirects to the product page with an error message' do
                post :insertar, params: { product_id: product.id, solicitud: { stock: 20 } }
                expect(flash[:error]).to eq('No hay suficiente stock para realizar la solicitud!')
                expect(response).to redirect_to("/products/leer/#{product.id}")
            end

            it 'solicitud de compra correcxta' do
                post :insertar, params: { product_id: product.id, solicitud: { stock: 2 } }
                expect(flash[:notice]).to eq('Solicitud de compra creada correctamente!')
                expect(response).to redirect_to("/products/leer/#{product.id}")
            end
        end
    end

    describe 'DELETE #eliminar' do
        before do
            sign_in user

        end

        it 'deletes the solicitud' do
            delete :eliminar, params: { id: solicitud.id }
            expect(flash[:notice]).to eq('Solicitud eliminada correctamente!')
            expect(response).to redirect_to('/solicitud/index')
        end

        it 'does not delete the solicitud' do
            allow_any_instance_of(Solicitud).to receive(:destroy).and_return(false)
            delete :eliminar, params: { id: solicitud.id }
            expect(flash[:error]).to eq('Hubo un error al eliminar la solicitud!')
            expect(response).to redirect_to('/solicitud/index')
        end
    end

    describe 'PUT #actualizar' do
        before do
            sign_in user
        end

        it 'updates the solicitud' do
            put :actualizar, params: { id: solicitud.id }
            expect(flash[:notice]).to eq('Solicitud aprobada correctamente!')
            expect(response).to redirect_to('/solicitud/index')
        end

        it 'does not update the solicitud' do
            allow_any_instance_of(Solicitud).to receive(:update).and_return(false)
            put :actualizar, params: { id: solicitud.id }
            expect(flash[:error]).to eq('Hubo un error al aprobar la solicitud!')
            expect(response).to redirect_to('/solicitud/index')
        end
    end

end