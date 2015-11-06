require_relative '../../app.rb'
require_relative '../helpers/test_helper.rb'

class TestInterfaceTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL


  def setup
    User.destroy_all
    Tweet.destroy_all
    Follow.destroy_all
  end

  def test_creates_new_user_called_test_user
    visit '/test/reset'
    assert User.exists?(user_name: "test_user") , "new test user not created at test reset"
  end

  def test_if_test_user_exists_delete_all_existing_followers
    visit '/test/reset'
    test_user = User.find_by_user_name("test_user")
    assert !Follow.exists?(user_id: test_user.id), "folowers of test user were not deleted"
  end

  def test_if_test_user_exists_delete_all_existing_tweets
    visit '/test/reset'
    test_user = User.find_by_user_name("test_user")
    assert !Tweet.exists?(user_id: test_user.id), "tweets of test user were not deleted"
  end

  def test_reset_redirects_to_test_user_timeline
    visit '/test/reset'
    assert page.has_content?('test_user'), "test reset redirection failed"
  end

  def test_test_seed_creates_n_fake_users
    initial_users_count = User.all.size
    visit '/test/seed/12'
    assert_equal(initial_users_count+12, User.all.size , msg = "seed doesn't create n fake users")
  end

  def test_generate_n_tweets
    test_params = {user_name: "test_user",
                   name:"test user",
                   password: "test123",
                   email: "testuser@test.com"}
    User.create(test_params)
    test_user = User.find_by_user_name("test_user")
    initial_tweets_count = test_user.tweets.count
    visit '/test/tweets/12'
    assert_equal(initial_tweets_count+12, test_user.tweets.count , msg = "doesn't create n tweets for test user")
  end

  def test_test_n_followers_for_test_user
    test_params = {user_name: "test_user",
                   name:"test user",
                   password: "test123",
                   email: "testuser@test.com"}
    User.create(test_params)
    10.times { Fabricate(:user) }
    test_user = User.find_by_user_name("test_user")
    initial_followers_count = test_user.followers.count
    visit '/test/follow/7'
    assert_equal(initial_followers_count+7, test_user.followers.count , msg = "doesn't make n users follow test user")
  end

end
