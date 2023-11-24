require 'rails_helper'

RSpec.describe 'Navigation', type: :system do
    describe "Mi prueba con Capybara", :capybara do
    it 'navigates from home page to products page' do
      visit root_path
      click_on 'Productos'
      expect(page).to have_current_path('/products/index')
    end

    it 'navigates from home page to contact page' do
      visit root_path
      click_on 'Contacto'
      expect(page).to have_current_path('/contacto')
    end

    it 'navigates from home page to login page' do
      visit root_path
      click_on 'Iniciar Sesión'
      expect(page).to have_current_path(new_user_session_path)
    end
  end
end
