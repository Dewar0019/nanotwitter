require './helpers/tweet_helper'

class TweetController < ApplicationController
  helpers Sinatra::TweetHelpers

  post '/tweets/new' do
    new_tweet = Tweet.new(user_id: session[:user_id], text: params[:tweet])
    if new_tweet.save
      redirect '/'
    else
      "Error"
    end
  end

  post '/tweets/:id/retweet' do
    action_tweet(:retweet)
  end
  post '/tweets/:id/favorite' do
    action_tweet(:favorite)
  end
end
