require './helpers/tweet_helper'
require './helpers/user_helper'

class UserController < ApplicationController
  helpers Sinatra::UserHelpers
  helpers Sinatra::TweetHelpers

  get '/signup' do
    erb :signup
  end

  post '/signup' do
    new_user = User.new(params)
    if new_user.save
      login(new_user)
      redirect '/'
    else
      flash[:notice] = "Error in signup"
      redirect '/signup'
    end
  end

  get '/users/:id' do
    @tweets = Timeline.recent(50, user)
    erb :users
  end

  get '/users/:id/tweets' do
    @tweets = Tweet.recent(50, user)
    erb :user_tweets
  end

  get '/users/:id/followings' do
    @users = Follow.get_followings(user)
    erb :followings
  end

  get '/users/:id/followers' do
    @users = Follow.get_followers(user)
    erb :followers
  end

  # current user follows user_id
  post '/users/:id/followers/new' do
    new_follow = Follow.new(user_id: session[:user_id], following_id: params[:id])
    if new_follow.save
      redirect "/users/#{current_user.id}/followings"
    else
      "Error"
    end
  end

  post '/users/:id/followers/delete' do
    Follow.find_by(user_id: session[:user_id], following_id: params[:id]).destroy
    redirect "/users/#{current_user.id}/followings"
  end

  get '/users/:id/favorites' do
    @tweets = Favorite.recent(50, user)
    erb :favorites
  end

  get '/users/:id/retweets' do
    @tweets = Retweet.recent(50, user)
    erb :retweets
  end
end
