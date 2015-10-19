class User < ActiveRecord::Base
	validates :user_name, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

	has_many :favorites
	has_many :tweets
	has_many :messages
	has_many :retweets
	has_many :replys
end
