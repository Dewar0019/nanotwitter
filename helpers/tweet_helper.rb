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

    ##
    # returns cache key for logged in user's timeline
    def timeline_cache_key
      "timeline/#{current_user.cache_key}"
    end

    ##
    # return cache key for 100 recent tweets list
    def recent_tweets_list_cache_key
      "list/#{Tweet.most_recent_updated.cache_key}"
    end

    ##
    # return cache key for tweet list created by user
    def user_tweets_list_cache_key
      "list/#{user.cache_key}"
    end

    ##
    # return cache key for retweets list by user
    def retweets_list_cache_key
      "retweet/#{user.cache_key}"
    end

    ##
    # return cache key for favorites list by user
    def favorites_list_cache_key
      "favorite/#{user.cache_key}"
    end
  end
end
