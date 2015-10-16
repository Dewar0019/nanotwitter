class User < ActiveRecord::Base
	has_many :favorite
	has_many :tweet
	has_many :message
	has_many :retweet
	has_many :reply
end