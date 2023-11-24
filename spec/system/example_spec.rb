require 'rails_helper'

RSpec.describe "Ejemplo de prueba de sistema", type: :system do
  it "muestra la página de inicio" do
    visit root_path
    assert_equal "/", current_path
  end
end
