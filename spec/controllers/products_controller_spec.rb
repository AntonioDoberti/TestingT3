require 'rails_helper'

RSpec.describe ProductsController, type: :controller do
  let(:admin_user) { User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', role: 'admin') }
  let(:product_params) { { product: { nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha' } } }
  let(:invalid_product_params) { { product: { nombre: '', precio: 100, stock: 10, categories: 'Invalid Category' } } }
  let!(:product) { Product.create(nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha', user: admin_user) }
  let(:review) { Review.create(product_id: product.id, user_id: admin_user.id, description: 'Test Comment', calification: 5)}

  before do
    sign_in admin_user
  end

  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe 'det index arroja bien los productos' do
    it 'retorna la lista correcta de productos' do
      get :index
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'GET index invalid category' do
    it 'category not present' do
      get :index, params: { category: 'Invalid Category' }
      expect(assigns(:products)).to eq([])
    end
  end

  describe 'GET index params not present' do
    it 'category not present' do
      get :index, params: { category: '' }
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'index params[:category].present? && params[:search].present?' do
    it 'category and search present' do
      get :index, params: { category: 'Cancha', search: 'Test' }
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'elsif params[:search].present?' do
    it 'search present' do
      get :index, params: { search: 'Test' }
      expect(assigns(:products)).to eq([product])
    end
  end

  describe 'GET leer' do
    it 'returns a success response' do
      get :leer, params: { id: product.id }
      expect(response.status).to eq(200)
    end
  end

  describe 'GET lee correctamente' do
    it 'retorna el producto correcto' do
      get :leer, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe 'get leer los detalles del producto' do
    it 'retorna los detalles del producto' do  
      get :leer, params: { id: product.id }
      expect(assigns(:product)).to eq(product)
    end
  end

  describe ' leer  @reviews.each do |review|' do
    it 'retorna las reviews del producto' do
      get :leer, params: { id: product.id }
      #expect #<ActiveRecord::Associations::CollectionProxy []>
      expect(assigns(:reviews)).to eq([])
    end
  end

  describe 'leer @calification_mean = else ' do
    it 'retorna el promedio de calificaciones del producto' do
      get :leer, params: { id: product.id }
      expect(assigns(:calification_mean)).to eq(nil)
    end
  end

  describe 'Crear un producto' do 
    it 'debe ser exitoso' do
      get :crear
      expect(response).to render_template('crear')
    end
  end

  describe 'Insertar deseado' do
    it 'inserta un producto a la lista de deseados' do
      get :insert_deseado, params: { product_id: product.id }
      expect(flash[:notice]).to eq('Producto agregado a la lista de deseados')
      expect(response).to redirect_to("/products/leer/#{product.id}")
    end
  end

  describe 'Insertar deseado' do
    it 'no inserta un producto a la lista de deseados' do
      get :insert_deseado, params: { product_id: product.id }
      expect(flash[:error]).to eq(nil)
      expect(response).to redirect_to("/products/leer/#{product.id}")
    end
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

RSpec.describe ProductsController, type: :controller do
  let(:user) { User.create!(name: 'Admin', email: 'admin@example.com', password: 'password', role: 'user') }
  let(:product_params) { { product: { nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha' } } }
  let(:invalid_product_params) { { product: { nombre: '', precio: 100, stock: 10, categories: 'Invalid Category' } } }
  let!(:product) { Product.create(nombre: 'Test Product', precio: 100, stock: 10, categories: 'Cancha', user: user) }

  before do
    sign_in user
  end

  describe 'POST insertar' do
    context 'with invalid user' do
      it 'Hubo un error al guardar el producto:' do
        post :insertar, params: product_params
        expect(flash[:alert]).to include('Debes ser un administrador para crear un producto.')
        expect(response).to redirect_to('/products/index')
      end
    end
  end

  describe 'GET actualizar' do
    context 'with invalid user' do
      it 'Hubo un error al guardar el producto:' do
        get :actualizar_producto, params: { id: product.id }
        expect(flash[:alert]).to include('Debes ser un administrador para modificar un producto.')
        expect(response).to redirect_to('/products/index')
      end
    end
  end

  describe 'DELETE eliminar' do
    context 'with invalid user' do
      it 'Hubo un error al guardar el producto:' do
        delete :eliminar, params: { id: product.id }
        expect(flash[:alert]).to include('Debes ser un administrador para eliminar un producto.')
        expect(response).to redirect_to('/products/index')
      end
    end
  end
end