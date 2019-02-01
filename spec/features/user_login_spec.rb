require 'rails_helper'

RSpec.feature "UserLogins", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  scenario "able to see the login form" do 
  	visit('/login')
  	expect(page).to have_content(/email/i)
  	expect(page).to have_content(/password/i)
  end

  scenario "able to login" do 
    user
  	login(user, 'gaggag')
    
    expect(page).to have_content(user.name)
    expect(page).to have_content(other_user.name)
  	expect(page).to have_link(nil, user_path(user))  
  end

  context "when invalid credential" do 
  	scenario "unable to login" do 
  		visit('/login')
  		fill_in "session_email", :with => 'invalid@mail.com'
  		fill_in "session_password", :with => 'invalidpassword'
  		click_button "Log in"

  		expect(page).to have_content('Invalid email/password combo')
  	end
  end
end
