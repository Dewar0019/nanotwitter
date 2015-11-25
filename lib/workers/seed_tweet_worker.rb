require './helpers/test_helper'

class SeedTweetWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    columns = [:user_id, :text, :created_at, :updated_at]
    values = []

    number.times do
      values << %Q[
        (#{test_user.id}, "#{Faker::Company.catch_phrase}",
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      ]
    end

    ActiveRecord::Base.connection.execute(
      "INSERT INTO tweets (#{columns.join(',')}) VALUES #{values.join(',')}"
    )
  end
end
