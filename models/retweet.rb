class Retweet < ActiveRecord::Base
  belongs_to :user, touch: true
  belongs_to :tweet, counter_cache: true, touch: true

  class << self
    ##
    # returns n recent retweets by user
    def recent(n, user)
      ids = Retweet.where(user: user).order(created_at: :desc).pluck(:tweet_id).first(n)
      Tweet.includes(:user).where(id: ids).order(created_at: :desc)
    end
  end
end
