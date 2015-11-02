# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'


class MyTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL



  def test_wrong_signup
    visit '/signup'
    click_button('Submit')
    assert page.has_content?('Error in signup'), "Sign up click button not redirecting"
  end



end