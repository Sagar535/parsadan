require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
	# normal user
	let(:user) {
		create(:user)
	}

	# sample micropost 
	let(:sample_post) {
		{
		params: {
			micropost: {
				content: 'Lorem ipsum dolor it'
				}
			}
		}
	}

	describe 'POST #create' do 
		context "non logged in user posts" do
			it "should not create the post" do
				expect{
					post :create, sample_post
				}.not_to change(Micropost, :count)
			end
		end

		context "logged in user posts" do
			it "should create the post" do
				session[:user_id] = user.id
				expect {
					post :create, sample_post
				}.to change(Micropost, :count).by(1)
			end

			it "should redirect to root url" do 
				session[:user_id] = user.id
				post :create, sample_post
				expect(response).to redirect_to(root_url)
			end
		end
	end

	describe 'DELETE #destroy' do 
		context "non logged in user" do end
		context "non admin logged in user" do end
		context "logged in admin" do end
	end
end
