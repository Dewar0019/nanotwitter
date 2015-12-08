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

  get '/api/v1/users/:id' do
    user = User.find_by(id: params[:id])
    if user
      user.to_json
    else
      error 404, {:error => "user not found"}.to_json
    end
  end

  get '/api/v1/tweets/:id' do
    if params[:id] == 'recent'
      tweet = Tweet.recent(50)
    else
      tweet = Tweet.find_by(id: params[:id])
    end

    if tweet
      tweet.to_json
    else
      error 404, {:error => "tweet not found"}.to_json
    end
  end

  get '/api/v1/users/:id/tweets' do
    user = User.find_by(id: params[:id])
    if !user
      error 404, {:error => 'no user found'}.to_json
    else
      user_recent_tweets = Tweet.recent(50, user)
      if user_recent_tweets
        user_recent_tweets.to_json
      else
        error 404, {:error => "no recent tweets found from user"}.to_json
      end
    end
  end

  get '/api/v1/users/:id/followers' do
     user = User.find_by(id: params[:id])
    if !user
      error 404, {:error => 'no user found'}.to_json
    else
      followers = Follow.get_followers(user)
      if followers
        followers.to_json
      else
        error 404, {:error => "no followers found"}.to_json
      end
    end
  end

  get '/api/v1/users/:id/following' do
     user = User.find_by(id: params[:id])
    if !user
      error 404, {:error => "no user found"}.to_json
    else
      followers = Follow.get_followings(user)
      if followers
        followers.to_json
      else
        error 404, {:error => "no followers found"}.to_json
      end
    end
  end

  get '/api/v1/users/:id/retweets' do
    user = User.find_by(id: params[:id])
    if !user
      error 404, {:error => "no user found"}.to_json
    else
      retweets = Retweet.recent(100, user)
      if retweets
        retweets.to_json
      else
         error 404, {:error => "no retweets found"}.to_json
      end
    end
  end

  get '/api/v1/users/:id/favorites' do
    user = User.find_by(id: params[:id])
    if !user
      error 404, {:error => "no user found"}.to_json
    else
      favorite = Favorite.recent(50, user)
      if favorite
        favorite.to_json
      else
         error 404, {:error => "no favorites found"}.to_json
      end
    end
  end
end
