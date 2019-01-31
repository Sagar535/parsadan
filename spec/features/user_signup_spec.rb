require 'rails_helper'

RSpec.feature "UserSignups", type: :feature do
  let(:user) { create(:user) }
  let(:valid_params) { build(:user).attributes.merge(password: 'gaggag') }

  scenario "able to see the signup form" do 
  	visit('/signup')
  	expect(page).to have_content(/sign up/i)
  	expect(page).to have_content(/name/i)
  	expect(page).to have_content(/email/i)
  	expect(page).to have_content(/password/i)
  	expect(page).to have_content(/confirmation/i)
  end

  scenario "able to signup" do 
  	visit('/signup')
  	fill_in "user_name", :with => "Random user"
  	fill_in "user_email", :with => "random@example.com"
  	fill_in "user_password", :with => "gaggag"
  	fill_in "user_password_confirmation", :with => "gaggag"

  	click_button "Submit"

  	expect(page).to have_content('Please check your email to activate your account.')
  end
end
