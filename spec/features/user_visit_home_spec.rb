require 'rails_helper'

RSpec.feature "UserVisitHomes", type: :feature do
  let(:user) { create(:user) }
  let(:post) { create(:micropost, user: user) }

  scenario "able to see the home page by non logged in user" do 
  	visit('/')
  	expect(page).to have_content(/ruby on rails/i)
  	expect(page).to have_content(/sign up/i)
  	expect(page).to have_link('rubyonrails.com')
  end

  scenario "able to see the feeds by logged in user" do
  	user 
  	post

  	login(user, 'gaggag')
  	visit('/')
  	expect(page).to have_content(user.followers.count)
  	expect(page).to have_content(user.following.count)
  	expect(page).to have_content(post.content)
  end
end
