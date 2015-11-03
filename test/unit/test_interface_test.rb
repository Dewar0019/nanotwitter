require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'


class TestInterfaceTest < MiniTest::Test

  include Rack::Test::Methods

  include Capybara::DSL

  def test_creates_new_user_called_test_user
    visit '/test/reset'
    assert User.exists?(user_name: "test_user") , "new test user not created at test reset"
  end

  def test_if_test_user_exists_delete_all_existing_followers
    visit '/test/reset'
    test_user = User.find_by_user_name("test_user")
    assert !Follow.exists?(user_id: test_user.id), "folowers of test user were not deleted"
  end

  def test_if_test_user_exists_delete_all_existing_followers
    visit '/test/reset'
    test_user = User.find_by_user_name("test_user")
    assert !Tweet.exists?(user_id: test_user.id), "tweets of test user were not deleted"
  end

  def test_reset_redirects_to_test_user_timeline
    visit '/test/reset'
    assert page.has_content?('test_user'), "test reset failed"
  end

end