require 'rails_helper'
require './test/test_helper'
# reqjuire

RSpec.describe UsersController, type: :controller do 
	# users with admin privilege
	let(:super_user) { create(:user, :super) }

	let (:another_super_user) { create(:user, :super) }

	# user without admin privilege
	let(:shikhar) { create(:user) }

	# valid seesion for shikhar
	let(:valid_session) { { user_id: shikhar.id } }

	# valid admin session
	let(:admin_session) { { user_id: super_user.id } }

	#valid user parameters 
	 let (:valid_params) do
       {
           user: {
                   name: 'sagar',
                   email: 'gag@gag.gag',
                   password: 'gaggag',
                   password_confirmation: 'gaggag'
           }
       }
   end

	# invalid user parameters
	let (:invalid_params) { { user: build(:user, email: '').attributes } }


	describe "GET #new" do 
		it "should get new" do 
			get :new
			expect(response).to be_successful
		end
	end

	describe "GET #index" do 
		it "should not allow non logged in user to access" do 
			get :index
			expect(response).not_to be_successful 
		end

		it "should allow logged in user to access" do 
			get :index, session: valid_session
			expect(response).to be_successful
		end
	end

	describe "GET #show" do 
		it "should get show" do 
			get :show, params: { id: shikhar.id }
			expect(response).to be_successful
		end
	end

	describe "GET #edit" do 
		it "returns a success response for logged in user" do
			get :edit, params: {id: shikhar.id}, session: valid_session
			expect(response).to be_successful
		end

		it "returns a fail response for non logged in user" do 
			get :edit, params: {id: shikhar.id}
			expect(response).not_to be_successful
		end
	end

	describe "POST #create" do 
		before (:all) do 
			ActionMailer::Base.deliveries.clear
		end

		context "with valid params" do 
			it "should create a user on sign up" do
				expect {
					post :create, params: valid_params
				}.to change(User, :count).by(1)
			end

			it "should redirect to root path" do 
				post :create, params: valid_params
				expect(response).to redirect_to(root_url)
			end

			it "should send a mail to user" do
				expect {
					post :create, params: valid_params
				}.to change(ActionMailer::Base.deliveries, :size).by(1)
			end
		end

		context "with invalid params" do 
			it "should redirect to sign up page" do 
				post :create, params: invalid_params
				expect(response).to render_template('users/new')
			end
		end
	end

	describe "PUT #update" do 
		context "when user is not logged in" do 
			it "should redirect to login page" do 
				put :update, params: {
					id: shikhar.id,
					user: {
						name: 'Sagar',
						email: 's@example.com'
					}
				}

				expect(response).to redirect_to(login_url)
			end
		end

		context "when user is not correct" do 
			it "should redirect to root_url" do 
				put :update, params: {
					id: super_user.id,
					user: {
						name: 'Shikhar',
						email: 'shikhar@gag.gag'
					}
				}, 
				session: valid_session

				expect(response).to redirect_to(root_url)
			end

			it "should not allow the admin attribute to be edited via the web" do
				put :update, params: {
					id: shikhar.id,
					user: {
						password: 'gaggag',
						password_confirmation: 'gaggag',
						admin: true
					},
				}, session: valid_session
				expect(shikhar.reload.admin?).to be false
			end
		end

		context "when params are invalid" do 
			it "should render edit page" do 
				put :update, params: {
					id: shikhar.id,
					user: {
						name: '',
						email: ''
					}
				},
				session: valid_session

				expect(response).to render_template('users/edit')
			end
		end

		context "when everything is well" do 
			it "should redirect to the user" do 
				put :update, params: {
					id: shikhar.id, 
					user: {
						name: 'shikhar',
						password: 'gaggag',
						password_confirmation: 'gaggag'
					}
				},
				session: valid_session

				expect(response).to redirect_to(shikhar)
			end
		end
	end

	describe "DELETE #destroy" do 
		context "when user is not admin" do 
			it "should not allow the user to delete" do
				shikhar
				expect {
					delete :destroy, params: {id: shikhar.id}, 
					session: valid_session
				}.not_to change(User, :count)
			end
		end

		context "when user is admin" do 
			it "should not allow to delete other admin" do 
				another_super_user
				super_user
				expect {
					delete :destroy, params: {id: another_super_user.id},
					session: admin_session
				}.not_to change(User, :count)
			end

			it "should delete other user" do 
				super_user
				shikhar
				expect {
					delete :destroy, params: {id: shikhar.id},
					session: admin_session
				}.to change(User, :count).by(-1)
			end
		end
	end
end 
