require 'rails_helper'

RSpec.feature "UserMicroposts", type: :feature do
  let(:user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  before do 
  	login(user, 'gaggag')
  end

  context "post with invalid content" do 
  	scenario "sees the error messages" do
  		visit '/'
  		fill_in 'micropost_content', with: ''
  		click_button 'Post'
  		expect(page).to have_content("Content can't be blank")
  	end
  end
  context "post with invalid file format" do
  	scenario "sees the error message" do 
  		visit '/'
  		fill_in 'micropost_content', with: 'lorem'
  		attach_file 'micropost_picture', Rails.root + 'spec/fixtures/languages.csv'
  		click_button 'Post'
  		expect(page).to have_content("Picture You are not allowed to upload \"csv\"")
  	end
  end
  
  context "post with valid content" do
  	scenario "sees the success message" do 
  		visit '/'
  		fill_in 'micropost_content', with: 'lorem'
  		attach_file 'micropost_picture', Rails.root + 'spec/fixtures/screen.png'
  		click_button 'Post'
  		expect(page).to have_content("Micropost created!")
  	end
  end
end
