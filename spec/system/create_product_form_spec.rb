require 'rails_helper'

RSpec.describe 'CreateProduct', type: :system do
  before do
    # Assuming you have a factory for users
    user = FactoryBot.create(:user, role: 'admin')
    login_as(user, scope: :user)
  end

  describe "Mi prueba con Capybara", :capybara do
    it 'creates a product successfully' do
      visit products_crear_path
      fill_in 'Nombre', with: 'Test Product'
      select 'Cancha', from: 'product[categories]'
      fill_in 'Precio', with: 100
      fill_in 'Stock', with: 50
      click_button 'Guardar'
      expect(page).to have_content('Producto creado Correctamente !')
    end
  end
  describe "Mi prueba con Capybara", :capybara do
    it 'fails to create a product without a name' do
      visit products_crear_path
      fill_in 'Precio', with: 100
      fill_in 'Stock', with: 50
      click_button 'Guardar'
      expect(current_path).to eq(products_crear_path)
    end
    end

    describe "Mi prueba con Capybara", :capybara do
    it 'fails to create a product without a price' do
      visit products_crear_path
      fill_in 'Nombre', with: 'Test Product'
      fill_in 'Stock', with: 50
      click_button 'Guardar'
      expect(current_path).to eq(products_crear_path)
    end
  end

  describe "Mi prueba con Capybara", :capybara do
    it 'fails to create a product without stock' do
      visit products_crear_path
      fill_in 'Nombre', with: 'Test Product'
      fill_in 'Precio', with: 100
      click_button 'Guardar'
      expect(current_path).to eq(products_crear_path)
    end
  end
end
