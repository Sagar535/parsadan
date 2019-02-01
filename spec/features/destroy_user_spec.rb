require 'rails_helper'

RSpec.feature "DestroyUsers", type: :feature do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:super_user) { create(:user, :super) }

  before do
  	login(current_user, 'gaggag')

  	other_user
  	visit '/users'
  end
  context "when admin visits" do
	let(:current_user) { super_user }
  	scenario "shows the delete" do
  		expect(page).to have_content('delete')
  		expect(page).to have_link('delete')
  	end
  	scenario "deletes the user" do 
  		click_link 'delete'
  		page.accept_alert
  		expect(page).to have_content('User deleted')
  	end
  end

  context "when normal user visits" do
	let(:current_user) { user }
  	scenario "won't shows the delete" do
		expect(page).not_to have_content('delete')
  	end
  end
end
