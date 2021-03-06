require './helpers/tweet_helper'
require './helpers/user_helper.rb'

class HomepageController < ApplicationController
  helpers Sinatra::TweetHelpers
  helpers Sinatra::UserHelpers

  get '/' do
    if login?
      @tweets = Timeline.recent(50, current_user)
      set_last_modified(current_user)
      set_etag(current_user)
    else
      @tweets = Tweet.recent(50)
      t = Tweet.most_recent_updated
      unless t.blank?
        set_last_modified(t)
        set_etag(t)
      end
    end

    erb :index
  end

end
