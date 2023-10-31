require 'rails_helper'

RSpec.describe ReviewController, type: :controller do
  let(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }
  let(:valid_params) { { product_id: product.id, tittle: 'Good Product', description: 'This is a good product', calification: 4 } }
  let(:invalid_params) { { product_id: product.id, tittle: '', description: 'This is a bad product', calification: 6 } }
  let!(:review) { Review.create!(tittle: 'Test Review', description: 'This is a test review', calification: 5, product: product, user: user) }

  before do
    sign_in user
  end

  describe 'POST #insertar' do
    context 'with valid params' do
      it 'creates a new review' do
        expect {
          post :insertar, params: valid_params
        }.to change(Review, :count).by(1)
        expect(flash[:notice]).to eq('Review creado Correctamente !')
        expect(response).to redirect_to("/products/leer/#{product.id}")
      end
    end

    context 'with invalid params' do
      it 'does not create a new review' do
        expect {
          post :insertar, params: invalid_params
        }.not_to change(Review, :count)
        expect(flash[:error]).to include('Hubo un error al guardar la reseña')
        expect(response).to redirect_to("/products/leer/#{product.id}")
      end
    end
  end

  describe 'PATCH #actualizar_review' do
    context 'with valid params' do
      it 'updates the review' do
        patch :actualizar_review, params: { id: review.id, tittle: 'Updated Review', description: 'This is an updated review', calification: 3 }
        review.reload
        expect(review.tittle).to eq('Updated Review')
        expect(response).to redirect_to("/products/leer/#{review.product.id}")
      end
    end

    context 'with invalid params' do
      it 'does not update the review' do
        patch :actualizar_review, params: { id: review.id, tittle: '', description: 'This is an updated review', calification: 6 }
        review.reload
        expect(review.tittle).not_to eq('')
        expect(flash[:error]).to include('Hubo un error al editar la reseña')
        expect(response).to redirect_to("/products/leer/#{review.product.id}")
      end
    end
  end

  describe 'DELETE #eliminar' do
    it 'deletes the review' do
      expect {
        delete :eliminar, params: { id: review.id }
      }.to change(Review, :count).by(-1)
      expect(response).to redirect_to("/products/leer/#{review.product.id}")
    end
  end
end
