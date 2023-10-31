require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin_user) { User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', role: 'admin') }
  let(:product_params) { { product: { nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha' } } }
  let(:invalid_product_params) { { product: { nombre: '', precio: 100, stock: 10, categories: 'Invalid Category' } } }
  let!(:product) { Product.create(nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha', user: admin_user) }

  before do
    sign_in admin_user
  end

  describe 'POST #insertar' do
    context 'with valid params' do
      it 'creates a new product' do
        expect {
          post :insertar, params: product_params
        }.to change(Product, :count).by(1)
        expect(flash[:notice]).to eq('Producto creado Correctamente !')
        expect(response).to redirect_to('/products/index')
      end
    end

    context 'with invalid params' do
      it 'does not create a new product' do
        expect {
          post :insertar, params: invalid_product_params
        }.not_to change(Product, :count)
        expect(flash[:error]).to include("Hubo un error al guardar el producto")
        expect(response).to redirect_to('/products/crear')
      end
    end
  end

  describe 'GET #actualizar' do
    it 'renders the actualizar template' do
      get :actualizar, params: { id: product.id }
      expect(response).to render_template('actualizar')
    end
  end

  describe 'PATCH #actualizar_producto' do
    context 'with valid params' do
      it 'updates the product' do
        patch :actualizar_producto, params: { id: product.id, product: { nombre: 'Updated Product' } }
        product.reload
        expect(product.nombre).to eq('Updated Product')
        expect(response).to redirect_to('/products/index')
      end
    end

    context 'with invalid params' do
      it 'does not update the product' do
        patch :actualizar_producto, params: { id: product.id, product: { nombre: '' } }
        product.reload
        expect(product.nombre).not_to eq('')
        expect(flash[:error]).to include('Hubo un error al guardar el producto')
        expect(response).to redirect_to("/products/actualizar/#{product.id}")
      end
    end
  end

  describe 'DELETE #eliminar' do
    it 'deletes the product' do
      expect {
        delete :eliminar, params: { id: product.id }
      }.to change(Product, :count).by(-1)
      expect(response).to redirect_to('/products/index')
    end
  end
end
