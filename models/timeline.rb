class Timeline < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  class << self
    ##
    # returns n recent tweets in an user's timeline
    def recent(n, user)
      ids = Timeline.where(user: user).order(created_at: :desc).pluck(:tweet_id).first(n)
      Tweet.includes(:user).where(id: ids)
    end
  end
end
