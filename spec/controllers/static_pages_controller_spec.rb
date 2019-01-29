require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
	describe "GET static pages" do 
		it "should return home path with success" do 
			get :home
			expect(response).to be_successful
		end

		it "should return help" do 
			get :help
			expect(response).to be_successful	
		end

		it "should return about" do 
			get :about
			expect(response).to be_successful
		end 

		it "should return contact" do 
			get :contact
			expect(response).to be_successful
		end
	end
end
