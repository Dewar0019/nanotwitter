require './helpers/database_cache_helper'

class Timeline < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :tweet, touch: true

  class << self
    include DatabaseCacheHelpers
    ##
    # returns n recent tweets in an user's timeline
    def recent(n, user)
      my_cache.fetch("timeline/" + user.cache_key) do
        ids = Timeline.where(user: user).pluck(:tweet_id)
        Tweet.includes(:user).where(id: ids).order(created_at: :desc).first(n)
      end
    end
  end
end
