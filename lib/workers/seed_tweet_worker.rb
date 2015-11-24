require './helpers/test_helper'
require "activerecord-import/base"

class SeedTweetWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    columns = [:user_id, :text]

    values = []
    number.times do
      values << [test_user.id, Faker::Company.catch_phrase]
    end

    Tweet.import columns, values
  end
end
