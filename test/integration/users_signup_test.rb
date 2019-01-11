require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid sign up not allowed" do
  	assert_no_difference 'User.count' do
	  	post signup_path, params: {
	  		user: {
	  			name: 'arun',
	  			email: 'arun@arun.com',
	  			password: 'gag',
	  			password_confirmation: 'gag'
	  		}
	  	}
	end 
	assert_template 'users/new'

	assert_select 'form[action="/signup"]'

	assert_select 'div#error_explanation'
	assert_select 'div.alert'
  end

  test "valid sign up success" do
  	assert_difference 'User.count', 1 do
  		post signup_path, params: {
  			user: {
  				name: 'dummy',
  				email: 'dummy@dum.com',
  				password: 'password',
  				password_confirmation: 'password'
  			}
  		}
  	end

  	follow_redirect!
  	assert_template 'users/show'

  	assert_select 'div.alert.alert-success'
  	assert_not flash[:danger]
  	assert flash[:success]
  end
end
