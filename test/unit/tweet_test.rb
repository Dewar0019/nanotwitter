require_relative '../../app.rb'
require_relative '../helpers/test_helper.rb'

class TweetTest < MiniTest::Test

  include Rack::Test::Methods

  def setup
    Tweet.destroy_all
    User.destroy_all
    User.create(:name => "u1", :user_name=>"u1", :email=>"u1@test.com", :password=>"passwordu1")
    @u1 = User.find_by_user_name("u1")
  end

  def test_tweet_cannot_save_without_text
    tweet = Tweet.new
    assert !tweet.save, "saved tweet without text"
  end

  def test_tweet_text_cannot_have_more_than_140_chars
    tweet = Tweet.new(user_id: @u1.id , text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce in ligula id diam volutpat aliquam ut eget arcu. Sed sollicitudin ipsum nibh, eu pulvinar massa rhoncus eu. Nunc blandit tellus in turpis vulputate luctus non quis sapien. Sed commodo molestie fermentum. Pellentesque eget nulla fringilla, aliquam neque sit amet, sodales.")
    assert !tweet.save, "saved tweet with more than 140 chars"
  end

  def test_tweet_gets_created
    tweet = Tweet.new(user_id: @u1.id  , text: "Lorem ipsum dolor sit amet, consectetur")
    assert tweet.save, "tweet doesn't get created"
  end

end
