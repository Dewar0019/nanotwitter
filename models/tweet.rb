class Tweet < ActiveRecord::Base
	belongs_to :user, counter_cache: true
	belongs_to :retweet
	belongs_to :favorite

	has_many :reply
	has_many :tag, through: :tweet_tag
end
