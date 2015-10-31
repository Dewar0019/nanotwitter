class HomepageController < ApplicationController
  get '/' do
    if login?
      user_ids = current_user.followings.pluck(:following_id) << current_user.id
      # tweets by user and their following
      @tweets = Tweet.recent(50, user_ids)
    else
      @tweets = Tweet.recent(50)
    end

    erb :index
  end
end
