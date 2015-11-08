class Timeline < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  class << self
    ##
    # returns n recent tweets in an user's timeline
    def recent(n, user)
      ids = Timeline.where(user: user).pluck(:tweet_id)
      Tweet.includes(:user).where(id: ids).order(created_at: :desc).first(n)
    end
  end
end
