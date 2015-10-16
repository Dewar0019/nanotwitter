class User < ActiveRecord::Base
	validates :user_name, :email, :password, presence: true   #would not be valid without username password and email
	validates_uniqueness_of :user_name, :email

	has_many :favorite
	has_many :tweet
	has_many :message
	has_many :retweet
	has_many :reply
end