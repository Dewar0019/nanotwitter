require 'fabrication'

class TestController < ApplicationController
  get '/test/reset' do
    test_params = {user_name: "test_user",
                   name:"test user",
                   password: "test123",
                   email: "testuser@test.com"}

    test_user = User.find_by_user_name("test_user")
    test_user.destroy if test_user

    test_user = User.new(test_params)
    test_user.save

    redirect "/users/#{test_user.id}"
  end

  get '/test/seed/:number' do
    params[:number].to_i.times { Fabricate(:user) }
    redirect '/'
  end

  get '/test/tweets/:number' do
    test_user = User.find_by_user_name("test_user")
    params[:number].to_i.times { Fabricate(:tweet, user_id: test_user.id) }

    redirect "/users/#{test_user.id}"
  end

  get '/test/follow/:number' do
    test_user = User.find_by_user_name("test_user")

    followings = ( User.ids - [ test_user.id ] ).sample( params[:number].to_i  )
    followings.each do |f|
      Follow.create(user_id: f, following_id: test_user.id)
    end

    redirect "/users/#{test_user.id}"
  end
end

