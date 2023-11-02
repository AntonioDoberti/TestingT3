require 'rails_helper'

RSpec.describe ShoppingCartController, type: :controller do
  let(:user) { User.create!(name: 'John Doe', email: 'test@example.com', password: 'password') }
  let(:product) { Product.create!(nombre: 'Test Product', categories: 'Cancha', stock: 10, precio: 100, user_id: user.id) }

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
      expect(response).to eq('')
    end
  end
end

describe "ShoppingCartsController#details" do
  context "when the user is not logged in" do
    it "redirects to the login page" do
      # Simular que el usuario no está loggeado
      session[:user_id] = nil

      # Llamar al método `details`
      get :details

      # Assert that the response is a redirect to the login page
      expect(response).to redirect_to(login_path)
    end
  end

  context "when the user is logged in and has a shopping cart" do
    it "calculates the total price and renders the `details` template" do
      # Simular que el usuario está loggeado y tiene un carrito de compras
      user = create(:user)
      sign_in user
      shopping_cart = create(:shopping_cart, user: user)
      @shopping_cart = shopping_cart

      # Llamar al método `details`
      get :details

      # Assert that the response status is 200 OK
      expect(response.status).to eq(200)

      # Assert that the `details` template was rendered
      expect(response).to render_template(:details)

      # Assert that the total price was calculated correctly
      expect(@total_pago).to eq(shopping_cart.precio_total + shopping_cart.costo_envio)
    end
  end

  context "when the user is logged in but does not have a shopping cart" do
    it "redirects to the shopping cart page with an alert message" do
      # Simular que el usuario está loggeado pero no tiene un carrito de compras
      user = create(:user)
      sign_in user
      @shopping_cart = nil

      # Llamar al método `details`
      get :details

      # Assert that the response status is 302 Redirect
      expect(response.status).to eq(302)

      # Assert that the response redirects to the shopping cart page
      expect(response).to redirect_to(carro_path)

      # Assert that the alert message is set
      expect(flash[:alert]).to eq('No tienes productos que comprar.')
    end
  end
end

describe 'POST #insertar_producto' do
  context 'when user is logged in' do
    before do
      sign_in user
    end

    it 'adds a product to the shopping cart' do
      post :insertar_producto, params: { product_id: product.id, add: { amount: 2 } }
      expect(response).to redirect_to('/carro')
      expect(flash[:notice]).to eq('Producto agregado al carro de compras')
    end
  end

  context 'when user is not logged in' do
    it 'redirects to the root path' do
      post :insertar_producto, params: { product_id: product.id, add: { amount: 2 } }
      expect(response).to redirect_to(root_path)
    end
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
