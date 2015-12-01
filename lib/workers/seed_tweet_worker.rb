require './helpers/test_helper'

class SeedTweetWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number, user=test_user)
    number.times { Fabricate(:tweet, user_id: user.id) }
  end
end
