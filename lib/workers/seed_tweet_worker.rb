require './helpers/test_helper'

class SeedTweetWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    number.times { Fabricate(:tweet, user_id: test_user.id) }
  end
end
