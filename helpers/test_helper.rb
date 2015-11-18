require 'sinatra/base'

module Sinatra
  module TestHelpers
    def test_params
      {user_name: "test_user",
       name:"test user",
       password: "test123",
       email: "testuser@test.com"}
    end

    def test_user
      User.find_by_user_name("test_user")
    end

    def create_new_test_user
      User.create(test_params)
    end
  end
end
