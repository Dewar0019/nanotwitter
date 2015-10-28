class Follow < ActiveRecord::Base
  belongs_to :user, counter_cache: :followings_count
  belongs_to :following,
    class_name: 'User',
    counter_cache: :followers_count

  class << self
    ##
    # returns true if user1 follows user2
    def follow?(user1, user2)
      !Follow.find_by(user_id: user1.id, following_id: user2.id).nil?
    end
  end
end
