class Follow < ActiveRecord::Base
  belongs_to :user, counter_cache: :followings_count, touch: true
  belongs_to :following,
    class_name: 'User',
    counter_cache: :followers_count,
    touch: true

  after_create :add_to_timeline_new_follower

  class << self
    ##
    # returns true if user1 follows user2
    def follow?(user1, user2)
      !Follow.find_by(user_id: user1.id, following_id: user2.id).nil?
    end
  end

  ##
  # add exisiting tweets to a new follower
  def add_to_timeline_new_follower
    self.following.tweets.each do |t|
      Timeline.create(user: user, tweet: t)
    end
  end

  private :add_to_timeline_new_follower
end
