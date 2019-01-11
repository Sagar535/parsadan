require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup 
  	@user = User.new(name: "Example User", email: "user@example.com",
  					password: 'example', password_confirmation: 'example')
  end

  test "should be valid" do
  	assert @user.valid?
  end

  test "name should be present" do
  	@user.name = "   "
  	assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = " "
  	assert_not @user.valid?
  end

  test "name should not be too long" do
  	@user.name = 'a' * 51
  	assert_not @user.valid?
  end

  test "email should not be too long" do
  	@user.email = 'a' * 250 + '@example.com'
  	assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
  	addresses = %w[user@example.com USER@foo.com a_us-err@us.com alice.bob@valid.com]

  	addresses.each do |address|
  		@user.email = address
  		assert @user.valid?, "#{address} should be valid"
  	end
  end

  test "email validation should not accept invalid addresses" do
  	addresses = %w[user@example,com user@foo+bar.com, use@user@foo.com, user_foo.com user@example..com]

  	addresses.each do |address|
  		@user.email = address
  		assert_not @user.valid? , "#{address} should not be valid"
  	end
  end

  test "email address should be unique" do
  	dup_user = @user.dup
  	dup_user1 = @user.dup
  	dup_user1.email = @user.email.upcase

  	@user.save

  	assert_not dup_user.valid?
  	assert_not dup_user1.valid?
  end

  test "email address should be downcase" do
  	@user.email = @user.email.upcase
  	final_email = @user.email.downcase

  	@user.save

  	assert_equal final_email, @user.email
  end

  test "password can't be blank" do
  	@user.password = @user.password_confirmation = ""
  	assert_not @user.valid?
  end

  test "password length must be equal or greater than 6" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
end
