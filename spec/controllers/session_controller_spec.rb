require 'rails_helper'

RSpec.describe SessionsController, type: :controller do 
	let! (:user) { create(:user) }

	let (:super_user) { create(:user, :super) }

	let (:not_active_user) { create(:user, :non_active) }
	# invalid params
	let (:valid_session) { { email: user.email, password: 'gaggag' } }
	let(:invalid_params) { { session: valid_session.merge(email: '') }	}
	let(:valid_params) { { session: valid_session }	}
	let(:not_active_params) { { session: valid_session.merge(email: not_active_user.email) } }

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
		context "when user is not activated" do
			it "should render login page" do 
				post :create, params: not_active_params, session: {}
				expect(response).to render_template('sessions/new')
			end
		end
		context "when all is well" do
			it "should redirect to user page" do 
				user
				post :create, params: valid_params
				expect(response).to redirect_to(user)
			end

			it "should log in the user" do 
				user
				post :create, params: valid_params
				expect(is_logged_in?).to be true
			end
		end
	end

	describe "DELETE #destroy" do 
		context "when user is not logged in" do end
		context "when user is logged in" do end
	end
end
