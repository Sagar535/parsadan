require 'rails_helper'

RSpec.describe SessionsController, type: :controller do 
	describe "GET #new" do 
		it "should get success response" do 
			get :new
			expect(response).to be_successful
		end
	end
end
