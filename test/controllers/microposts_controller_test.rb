require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect create when user not logged in" do 
  	get microposts_path
  	assert_redirect_to root_path
  end

  test "should redirect destroy when no log in" do
  	get microposts_destroy_path
  	assert_redirect_to root_path
  end
end
