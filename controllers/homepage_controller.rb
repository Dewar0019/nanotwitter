require './helpers/tweet_helper'

class HomepageController < ApplicationController
  helpers Sinatra::TweetHelpers

  get '/' do
    if login?
      @tweets = Timeline.recent(100, current_user)
      set_last_modified(current_user)
      set_etag(current_user)
    else
      @tweets = Tweet.recent(100)
      t = Tweet.most_recent_updated
      set_last_modified(t)
      set_etag(t)
    end

    erb :index
  end
end
