# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'


class MyTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL

  def test_root_path_works
    visit '/'
    assert page.has_no_content?('NOTACONTENT'), "home page path failed"
  end

  def test_root_path_signup
    visit '/signup'
    assert page.has_content?('Sign up'), "Sign up path failed"
  end

  def test_root_path_no_content
    visit '/signup'
    assert page.has_no_content?('DOESNOT EXIST'), "Sign up path failed"
  end

  def test_signin_and_tweet
    visit '/login'
    page.fill_in 'email', :with => 'testuser892@test.com'
    page.fill_in 'password', :with => 'testuser892' 
    click_button('Login')
    page.fill_in 'tweet', :with => 'new test tweet'
    click_button('Tweet')
    assert page.has_content?('new test tweet'), "Test failed, Tweet should post"
  end


end