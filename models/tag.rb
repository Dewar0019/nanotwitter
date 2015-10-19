class Tag < ActiveRecord::Base
	has_many :tweets, through: :tweet_tag
end
