require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
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
end
