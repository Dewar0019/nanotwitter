require 'fabrication'
require './helpers/test_helper'

class TestController < ApplicationController
  helpers Sinatra::TestHelpers

  get '/test/reset' do
    test_user.destroy if test_user
    create_new_test_user()
    redirect "/users/#{test_user.id}"
  end

  get '/test/seed/:number' do
    params[:number].to_i.times { Fabricate(:user) }
    redirect '/'
  end

  get '/test/tweets/:number' do
    params[:number].to_i.times { Fabricate(:tweet, user_id: test_user.id) }

    redirect "/users/#{test_user.id}"
  end

  get '/test/follow/:number' do
    followings = ( User.ids - [ test_user.id ] ).sample( params[:number].to_i  )
    followings.each do |f|
      Follow.create(user_id: f, following_id: test_user.id)
    end

    redirect "/users/#{test_user.id}"
  end
end

