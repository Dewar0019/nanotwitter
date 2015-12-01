require './helpers/test_helper'
require './lib/workers/reset_all_worker'
require './lib/workers/reset_testuser_worker'
require './lib/workers/seed_worker'
require './lib/workers/seed_tweet_worker'
require './lib/workers/seed_following_worker'

class TestController < ApplicationController
  helpers Sinatra::TestHelpers

  get '/test/status' do
    erb :status, layout: false
  end

  get '/test/reset/all' do
    ResetAllWorker.perform_async
    redirect '/test/status'
  end

  get '/test/reset/testuser' do
    ResetTestuserWorker.perform_async
    redirect '/test/status'
  end

  get '/test/seed/:number' do
    SeedWorker.perform_async(params[:number].to_i)
    redirect '/test/status'
  end

  get '/test/tweets/:number' do
    SeedTweetWorker.perform_async(params[:number].to_i)
    redirect '/test/status'
  end

  get '/test/tweet/:id' do
    SeedTweetWorker.perform_async(1, user)
    redirect '/test/status'
  end

  get '/test/follow/:number' do
    SeedFollowingWorker.perform_async(params[:number].to_i)
    redirect '/test/status'
  end

  get '/user/testuser' do
    redirect "/users/#{test_user.id}"
  end

  get '/user/testuser/tweet' do
    SeedTweetWorker.perform_async(1)
    redirect '/test/status'
  end
end
