require './helpers/test_helper'

class SeedFollowingWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    followings = ( User.ids - [ test_user.id ] ).sample( number )
    followings.each do |f|
      Follow.create(user_id: f, following: test_user)
    end
  end
end
