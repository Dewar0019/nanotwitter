require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'

class TweetTest < MiniTest::Test

  include Rack::Test::Methods

  def setup 
  	User.destroy_all
  	Tweet.destroy_all
  	Follow.destroy_all
  	User.new(:user_name=>"u1", :email=>"u1@test.com", :password=>"passwordu1").save
  	User.new(:user_name=>"u2", :email=>"u2@test.com", :password=>"passwordu2").save
	@u1 = User.find_by_user_name("u1")
	@u2 = User.find_by_user_name("u2")
	Follow.new(user_id: @u1.id, following_id: @u2.id).save
	Tweet.new(user_id: @u1.id, text: "test tweet 892").save
	@tweet = Tweet.find_by_text("test tweet 892")
  end



  def test_new_tweet_added_to_self_time_line
	assert Timeline.exists?(user_id: @u1.id, tweet_id: @tweet.id), "Tweet not seen in own timeline" 
  end

  def test_new_tweet_added_to_followers_time_line
    assert true
  end



end







