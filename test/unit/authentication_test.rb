# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'


class AuthenticationTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL

  def test_signup_with_blank_fields
    visit '/signup'
    click_button('Submit')
    assert page.has_content?('Error in signup'), "Test failed, Sign up with blank fields should not work"
  end

  def test_signup_with_already_existing_user
    visit '/signup'
    page.fill_in 'user_name', :with => 'testuser892'
    page.fill_in 'email', :with => 'testuser892@test.com'
    page.fill_in 'password', :with => 'testuser892' 
    click_button('Submit')
    assert page.has_content?('Error in signup'), "Test failed, Sign up with already existing user and email should not work"
  end

  def test_signin_with_blank_fields
    visit '/login'
    click_button('Login')
    assert page.has_content?('Wrong password or user doesnot exists'), "Test failed, Sign in with blank fields should not work"
  end

  


end