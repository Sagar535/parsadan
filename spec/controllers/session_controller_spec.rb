require 'rails_helper'

RSpec.describe SessionsController, type: :controller do 
	# invalid params
	let(:invalid_params) {
		{
			session: {
				email: 'random@random.com',
				password: 'password'
			}
		}
	}

	let(:valid_params) {
		{
			session: {
				emial: 'random@random.com',
				password: 'gaggag'
			}
		}
	}

	let (:user) {
		create(:user)
	}

	let (:super_user) {
		create(:super_user)
	}

	let (:not_active_user) {
		create(:non_active_user)
	}

	describe "GET #new" do 
		it "should get success response" do 
			get :new
			expect(response).to be_successful
		end
	end

	describe "POST #create" do 
		context "when attributes are wrong" do
			it "should render login page" do 
				post :create, params: invalid_params, session: {}
				expect(response).to render_template('sessions/new')
			end
		 end
		context "when user is not activated" do end
		context "when all is well" do end
	end

	describe "DELETE #destroy" do 
		context "when user is not logged in" do end
		context "when user is logged in" do end
	end
end
