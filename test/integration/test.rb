# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'
require_relative '../../controllers/homepage_controller.rb'

class MyTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL

  def test_root_path_works
    visit '/'
    assert page.has_content?('hello'), "custom fail msg"
  end
end