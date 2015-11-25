class Retweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true, touch: true
  belongs_to :tweet, counter_cache: true, touch: true

  class << self
    ##
    # returns n recent retweets by user
    def recent(n, user)
      $redis2.fetch("retweet/#{user.cache_key}") do
        ids = Retweet.where(user: user).order(created_at: :desc).pluck(:tweet_id).first(n)
        Tweet.includes(:user).where(id: ids).order(created_at: :desc)
      end
    end
  end
end
