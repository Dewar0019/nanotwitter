require 'digest/md5'
require './helpers/user_helper'

class UserController < ApplicationController
  helpers UserHelper

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
      @tweets = Timeline.recent(50, current_user)
    else
      @tweets = Tweet.recent(50, user)
    end
    erb :users
  end

  get '/users/:id/followings' do
    erb :followings
  end

  get '/users/:id/followers' do
    erb :followers
  end

  # current user follows user_id
  post '/users/:id/followers/new' do
    new_follow = Follow.new(user_id: session[:user_id], following_id: params[:id])

    if new_follow.save
      redirect "/users/#{params[:id]}"
    else
      "Error"
    end
  end

  post '/users/:id/followers/delete' do
    follow = Follow.find_by(user_id: session[:user_id], following_id: params[:id])
    Follow.destroy(follow.id)
    redirect "/users/#{params[:id]}"
  end
end
