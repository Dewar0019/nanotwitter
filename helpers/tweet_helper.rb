require 'sinatra/base'

module Sinatra
  ##
  # Helpers for Tweet controller
  module TweetHelpers
    ##
    # do an action (favorite, retweet) with a tweet
    def action_tweet(action)
      must_login

      if action == :retweet
        model = Retweet
      elsif action == :favorite
        model = Favorite
      end

      result = model.new(tweet_id: params[:id], user_id: session[:user_id])
      if result.save
        redirect "/users/#{session[:user_id]}/#{action}s"
      else
        "Error"
      end
    end
  end
end
