require 'rails_helper'

RSpec.describe 'UpdateProduct', type: :system do
  describe "Mi prueba con Capybara", :capybara do
    before do
      # Assuming you have a factory for users and products
      user = FactoryBot.create(:user, role: 'admin')
      @product = FactoryBot.create(:product, user_id: user.id)
      login_as(user, scope: :user)
    end

    it 'updates a product successfully' do
      visit "/products/actualizar/#{@product.id}"
      fill_in 'Nombre', with: 'Updated Product'
      click_button 'Guardar'
      expect(current_path).to eq(products_index_path)
    end

    it 'fails to update a product with a blank name' do
      visit "/products/actualizar/#{@product.id}"
      fill_in 'Nombre', with: ''
      click_button 'Guardar'
      expect(current_path).to eq("/products/actualizar/#{@product.id}")
    end

    it 'fails to update a product with a blank price' do
      visit "/products/actualizar/#{@product.id}"
      fill_in 'Precio', with: ''
      click_button 'Guardar'
      expect(current_path).to eq("/products/actualizar/#{@product.id}")
    end

    it 'fails to update a product with a blank stock' do
      visit "/products/actualizar/#{@product.id}"
      fill_in 'Stock', with: ''
      click_button 'Guardar'
      expect(current_path).to eq("/products/actualizar/#{@product.id}")
    end
  end
end
