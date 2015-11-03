class Retweet < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  class << self
    ##
    # returns n recent retweets by user
    def recent(n, user)
      ids = Retweet.where(user: user).order(created_at: :desc).pluck(:tweet_id).first(n)
      Tweet.includes(:user).where(id: ids)
    end
  end
end
