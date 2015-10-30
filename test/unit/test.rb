# test.rb
require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'

class UnitTest < MiniTest::Unit::TestCase

	 include Rack::Test::Methods


	def app
    	Sinatra::Application
  	end

	def test_root_path_works
    	get '/'
    	assert last_response.ok?
    	assert_equal page.has_content?("NanoTwitter")
  	end



end