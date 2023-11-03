require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
    describe 'rescue_from CanCan::AccessDenied' do
        controller do
            def index
                raise CanCan::AccessDenied
            end
        end

        it 'redirects to root_path' do
            routes.draw { get 'index' => 'anonymous#index' }
            get :index
            expect(response).to redirect_to(root_path)
        end
    end
end