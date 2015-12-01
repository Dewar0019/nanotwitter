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
    if current_user?(user)
      @tweets = Timeline.recent(100, current_user)
    else
      @tweets = Tweet.recent(100, user)
    end
    erb :users
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
      redirect "/users/#{current_user.id}" 
    else
      "Error"
    end
  end

  post '/users/:id/followers/delete' do
    follow = Follow.find_by(user_id: session[:user_id], following_id: params[:id])
    Follow.destroy(follow.id)
    redirect "/users/#{params[:id]}"
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
