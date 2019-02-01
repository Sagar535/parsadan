require 'rails_helper'

RSpec.feature "ProfileViews", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:micropost) { create(:micropost, user: user) }

  before do 
  	micropost
  end

  scenario "able to see the user profile" do 
  	visit(user_path(user))
  	expect(page).to have_content(user.name)
  	expect(page).to have_content(user.followers.count)
  	expect(page).to have_content(user.following.count)
  end

  context "when user has posts" do 
  	scenario "should sees the microposts" do
  		visit(user_path(user))
	  	expect(page).to have_content('Microposts')
	  	expect(page).to have_content(micropost.content)
  	end
  end

  context "when visitor is logged in" do
  	before do 
  		login(other_user, 'gaggag')
  		visit(user_path(user))
  	end 
  	scenario "should see the follow or unfollow button" do 
  		page.should have_selector(:link_or_button, 'Follow')
  	end

  	context "when visitor follows the user" do 
  		scenario "button changes from follow to unfollow" do 
  			click_button 'Follow'
  			page.should have_selector(:link_or_button, 'Unfollow')
  		end
  	end

  	context "when visitor unfollows the user" do 
  		scenario "button changes from unfollow to follow" do
  			click_button 'Follow'
  			click_button 'Unfollow'
  			page.should have_selector(:link_or_button, 'Follow')
  		end
  	end
  end 
end
