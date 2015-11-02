class TweetController < ApplicationController
  post '/tweets/new' do
    new_tweet = Tweet.new(user_id: session[:user_id], text: params[:tweet])
    if new_tweet.save
      redirect '/'
    else
      "Error"
    end
  end

  get '/retweet/:tweet_id' do
    if(login?)
      user_id = session[:user_id]
      retweet = Retweet.new(tweet_id: params[:tweet_id], user_id: user_id)
      if retweet.save
        redirect "/users/#{user_id}"
      else
        "Error"
      end
    else
      redirect "/"
    end
  end

  get '/favorite/:tweet_id' do
    if(login?)
      user_id = session[:user_id]
      favorite = Favorite.new(tweet_id: params[:tweet_id], user_id: user_id)
      if favorite.save
        redirect "/users/#{user_id}"
      else
        "Error"
      end
    else
      redirect "/"
    end  
  end

end

