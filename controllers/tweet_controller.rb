class TweetController < ApplicationController
  post '/tweets/new' do
    new_tweet = Tweet.new(user_id: session[:user_id], text: params[:tweet])
    if new_tweet.save
      redirect '/'
    else
      "Error"
    end
  end

  post '/tweets/:id/retweet' do
    must_login
    retweet = Retweet.new(tweet_id: params[:id], user_id: session[:user_id])
    if retweet.save
      redirect "/users/#{session[:user_id]}/retweets"
    else
      "Error"
    end
  end

  post '/tweets/:id/favorite' do
    must_login
    favorite = Favorite.new(tweet_id: params[:id], user_id: session[:user_id])
    if favorite.save
      redirect "/users/#{session[:user_id]}/favorites"
    else
      "Error"
    end
  end
end
