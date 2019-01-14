require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
	def setup
		@user = users(:sagar)
	end

  test 'unsuccessful login with invalid credential' do
  	get login_path
  	assert_template 'sessions/new'
  	post login_path, params: {session: {email: 'example@railstutorial.com', password: 'gggggg'}}
  	assert_template 'sessions/new'
  	assert_not flash.empty?
  	assert_select 'div.alert.alert-danger'
  	get root_path
  	assert flash.empty? 
  end

  test 'successful login with valid credential' do
  	post login_path, params: {session: {email: 'sagar@example.com', password: 'gaggag'}}
  	assert_redirected_to @user
  	follow_redirect!
  	assert_template 'users/show'
  	assert_select 'a[href=?]', login_path, count: 0
  	assert_select 'a[href=?]', logout_path
  	assert_select 'a[href=?]', user_path(@user)
    assert is_logged_in?
  end
end
