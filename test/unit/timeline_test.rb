require_relative '../../app.rb'
require_relative '../helpers/test_helper.rb'

class TweetTest < MiniTest::Test

  include Rack::Test::Methods

  def setup
    User.destroy_all
    Tweet.destroy_all
    Follow.destroy_all
    User.create(:name => "u1", :user_name=>"u1", :email=>"u1@test.com", :password=>"passwordu1")
    User.create(:name => "u1", :user_name=>"u2", :email=>"u2@test.com", :password=>"passwordu2")
    @u1 = User.find_by_user_name("u1")
    @u2 = User.find_by_user_name("u2")
    Follow.create(user_id: @u1.id, following_id: @u2.id)
    Tweet.create(user_id: @u1.id, text: "test tweet 892")
    @tweet = Tweet.find_by_text("test tweet 892")
  end

  def test_new_tweet_added_to_self_time_line
    assert Timeline.exists?(user_id: @u1.id, tweet_id: @tweet.id), "Tweet not seen in own timeline"
  end

end
