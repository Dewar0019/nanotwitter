class Tweet_tag < ActiveRecord::Base
	belongs_to :tweet
	has_many :tag
end
