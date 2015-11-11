require './helpers/tweet_helper'

class HomepageController < ApplicationController
  helpers Sinatra::TweetHelpers

  get '/' do
    if login?
      @tweets = Timeline.recent(100, current_user)
    else
      @tweets = Tweet.recent(100)
      t = Tweet.order(updated_at: :desc).first
      last_modified t.updated_at
      etag Digest::MD5.hexdigest(t.cache_key)
    end

    erb :index
  end
end
