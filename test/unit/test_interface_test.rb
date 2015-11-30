require_relative '../../app.rb'
require_relative '../helpers/test_helper.rb'
require 'sidekiq/testing'

class TestInterfaceTest < MiniTest::Test

  include Rack::Test::Methods
  include Sinatra::TestHelpers

  include Capybara::DSL


  def setup
    User.destroy_all
    Tweet.destroy_all
    Follow.destroy_all
    Sidekiq::Testing.inline!
  end

  def test_creates_new_user_called_test_user
    visit '/test/reset'
    assert !test_user.nil?, "new test user not created at test reset"
  end

  def test_if_test_user_exists_delete_all_existing_followers
    visit '/test/reset'
    assert !Follow.exists?(user: test_user),
           "folowers of test user were not deleted"
  end

  def test_if_test_user_exists_delete_all_existing_tweets
    visit '/test/reset'
    assert !Tweet.exists?(user: test_user),
           "tweets of test user were not deleted"
  end

  def test_test_seed_creates_n_fake_users
    initial_users_count = User.count

    visit '/test/seed/12'
    assert_equal initial_users_count+12, User.count,
                 "seed doesn't create n fake users"
  end

  def test_generate_n_tweets
    create_new_test_user
    initial_tweets_count = test_user.tweets_count

    visit '/test/tweets/12'
    assert_equal initial_tweets_count+12, test_user.tweets_count ,
                 "doesn't create n tweets for test user"
  end

  def test_test_n_followers_for_test_user
    create_new_test_user

    10.times { Fabricate(:user) }

    initial_followers_count = test_user.followers_count

    visit '/test/follow/7'
    assert_equal initial_followers_count+7, test_user.followers_count ,
                 "doesn't make n users follow test user"
  end
end
