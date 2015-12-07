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

    ##
    # returns all users who user1 follows
    def get_followings(user1)
      $redis2.fetch("followings/#{user1.cache_key}") do
        ids = Follow.where(user: user1).pluck(:following_id)
        User.where(id: ids)
      end
    end

    ##
    # returns all users who are followers of user1
    def get_followers(user1)
      $redis2.fetch("followers/#{user1.cache_key}") do
        ids = Follow.where(following: user1).pluck(:user_id)
        User.where(id: ids)
      end
    end
  end

  ##
  # add 50 most recent tweets to a new follower
  def add_to_timeline_new_follower
    Tweet.recent(50, self.following).each do |t|
      Timeline.create(user: user, tweet: t)
    end
  end

  private :add_to_timeline_new_follower
end
