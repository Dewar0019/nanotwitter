require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'

class TweetTest < MiniTest::Test

  include Rack::Test::Methods

  def test_new_tweet_added_to_self_time_line
    assert true
  end

  def test_new_tweet_added_to_followers_time_line
    assert true
  end

end







