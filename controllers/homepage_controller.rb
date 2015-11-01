class HomepageController < ApplicationController
  get '/' do
    if login?
      @tweets = Timeline.recent(50, current_user)
    else
      @tweets = Tweet.recent(50)
    end

    erb :index
  end
end
