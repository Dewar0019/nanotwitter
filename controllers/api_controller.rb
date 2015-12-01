require './helpers/test_helper'

class APIController < ApplicationController
  helpers Sinatra::TestHelpers

  get '/api/v1/testuser' do
    content_type :json
    test_user.to_json
  end

  get '/api/v1/users' do
    content_type :json
    { count: User.count }.to_json
  end

  get '/api/v1/follows' do
    content_type :json
    { count: Follow.count }.to_json
  end

  get '/api/v1/tweets' do
    content_type :json
    { count: Tweet.count }.to_json
  end
end
