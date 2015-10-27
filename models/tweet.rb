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
    # returns n recent tweets by an array of user_id sorted by created time
    # if user_ids is empty, returns n most recent tweets
    def recent(n, user_ids = [])
      if user_ids.empty?
        Tweet.includes(:user).order(created_at: :desc).first(n)
      else
        Tweet.includes(:user).where('user_id in (?)', user_ids).order(created_at: :desc).first(n)
      end
    end
  end

  ##
  # pretty print created time of a tweet
  # ie. 16 Oct 2015 22:17
  def pretty_print_date
    self.created_at.strftime("%-d %b %Y %H:%M")
  end
end
