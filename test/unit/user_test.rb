require_relative '../../app.rb' 
require_relative '../helpers/test_helper.rb'

class UserTest < MiniTest::Test

  include Rack::Test::Methods

  def setup 
    User.destroy_all
  end

  def test_user_attributes_must_not_be_empty
    user = User.new
    assert user.invalid?
    assert !user.save, "empty attributes user saved"
  end

  def test_user_need_unique_email
    User.new(:user_name=>"u1", :email=>"u1@test.com", :password=>"password").save
    user = User.new(:user_name=>"u2", :email=>"u1@test.com", :password=>"password")
    assert !user.save, "email uniqueness failed"
  end

  def test_user_need_unique_user_name
    User.new(:user_name=>"u1", :email=>"u1@test.com", :password=>"password").save
    user = User.new(:user_name=>"u1", :email=>"u2@test.com", :password=>"password")
    assert !user.save, "user_name uniqueness failed"
  end

  def password_needs_to_be_6_to_20_chars
    user = User.new(:user_name=>"u1", :email=>"u2@test.com", :password=>"12345")
    assert !user.save, "user_name uniqueness failed"
  end

end
