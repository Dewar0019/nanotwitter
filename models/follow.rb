class Follow < ActiveRecord::Base
  belongs_to :user, counter_cache: :followings_count
  belongs_to :following,
    class_name: 'User',
    counter_cache: :followers_count
end
