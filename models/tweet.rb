class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  has_many :favorites
  has_many :retweets
  has_many :replies
  has_many :tweet_tags
end
