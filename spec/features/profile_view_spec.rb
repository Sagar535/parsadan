require 'rails_helper'

RSpec.feature "ProfileViews", type: :feature do
  let(:user) { create(:user) }

  scenario "able to see the user profile" do 
  	visit(user_path(user))
  	expect(page).to have_content(user.name)
  	expect(page).to have_content(user.followers.count)
  	expect(page).to have_content(user.following.count)
  end
end
