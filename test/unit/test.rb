# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'


class MyTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL



  def test_signup_with_blank_fields
    visit '/signup'
    click_button('Submit')
    assert page.has_content?('Error in signup'), "Test failed, Sign up with blank fields should not work"
  end

  def test_successful_signup
    visit '/signup'
    page.fill_in 'user_name', :with => 'test_user'
    page.fill_in 'email', :with => 'testuser@test.com'
    page.fill_in 'password', :with => 'test123' 
    click_button('Submit')
    assert page.has_content?('Error in signup'), "Test failed, Sign up with already existing user and email should not work"
  end

end