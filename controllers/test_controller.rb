require './helpers/test_helper'
require './lib/workers/create_testuser_worker'
require './lib/workers/seed_worker'
require './lib/workers/seed_tweet_worker'
require './lib/workers/seed_following_worker'

class TestController < ApplicationController
  helpers Sinatra::TestHelpers

  get '/test/reset' do
    CreateTestuserWorker.perform_async
    redirect '/sidekiq'
  end

  get '/test/seed/:number' do
    SeedWorker.perform_async(params[:number].to_i)
    redirect '/sidekiq'
  end

  get '/test/tweets/:number' do
    SeedTweetWorker.perform_async(params[:number].to_i)
    redirect '/sidekiq'
  end

  get '/test/follow/:number' do
    SeedFollowingWorker.perform_async(params[:number].to_i)
    redirect '/sidekiq'
  end

  get '/user/testuser' do
    redirect "/users/#{test_user.id}"
  end

  get '/user/testuser/tweet' do
    SeedTweetWorker.perform_async(1)
    redirect '/sidekiq'
  end
end

