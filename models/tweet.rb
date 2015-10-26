class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  has_many :favorites
  has_many :retweets
  has_many :replies
  has_many :tweet_tags

  validates :text,
    presence: true,
    length: { minimum: 1, maximum: 140 }

  class << self
    ##
    # returns n recent tweets by user_id sorted by created time
    # if user_id is nil, returns n most recent tweets
    def recent(n, user_id = nil)
      if user_id
        Tweet.includes(:user).where(user_id: user_id).order(created_at: :desc).first(n)
      else
        Tweet.includes(:user).order(created_at: :desc).first(n)
      end
    end
  end
end
