require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  let(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }

  describe 'GET #show' do
    it 'redirects to the root path when user is not logged in' do
      get :show
      expect(response).to redirect_to(root_path)
    end

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'renders the show template' do
        get :show
        expect(response).to render_template('show')
      end
    end
  end

  describe 'GET #details' do
    it 'redirects to the root path when user is not logged in' do
      get :details
      expect(response).to redirect_to(root_path)
    end

    context 'when user is logged in' do
      before do
        sign_in user
      end

      it 'renders the details template' do
        get :details
        expect(response).to render_template('details')
      end
    end
  end

  describe 'POST #insertar_producto' do
    before do
      sign_in user
    end

    it 'adds a product to the shopping cart' do
      post :insertar_producto, params: { product_id: product.id, add: { amount: 2 } }
      expect(response).to redirect_to('/carro')
      expect(flash[:notice]).to eq('Producto agregado al carro de compras')
    end
  end

  describe 'DELETE #eliminar_producto' do
    before do
      sign_in user
    end

    it 'removes a product from the shopping cart' do
      shopping_cart = ShoppingCart.create!(user_id: user.id, products: { product.id.to_s => 2 })
      delete :eliminar_producto, params: { product_id: product.id }
      expect(response).to redirect_to('/carro')
      expect(flash[:notice]).to eq('Producto eliminado del carro de compras')
    end
  end

  describe 'POST #comprar_ahora' do
    before do
      sign_in user
    end

    it 'redirects to the details page' do
      post :comprar_ahora, params: { product_id: product.id, add: { amount: 1 } }
      expect(response).to redirect_to('/carro/detalle')
    end
  end

  describe 'POST #realizar_compra' do
    before do
      sign_in user
    end

    it 'redirects to the solicitudes index page' do
      shopping_cart = ShoppingCart.create!(user_id: user.id, products: { product.id.to_s => 2 })
      post :realizar_compra
      expect(response).to redirect_to('/solicitud/index')
      expect(flash[:notice]).to eq('Compra realizada exitosamente')
    end
  end

  describe 'GET #limpiar' do
    before do
      sign_in user
    end

    it 'redirects to the shopping cart page' do
      shopping_cart = ShoppingCart.create!(user_id: user.id, products: { product.id.to_s => 2 })
      get :limpiar
      expect(response).to redirect_to('/carro')
      expect(flash[:notice]).to eq('Carro de compras limpiado exitosamente')
    end
  end
end
