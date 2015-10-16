class Tweet < ActiveRecord::Base
	belongs_to :retweet
	belongs_to :user
	belongs_to :favorite
	has_many :reply
	has_many :tag, through: :tweet_tag
end