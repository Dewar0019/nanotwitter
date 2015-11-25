require './helpers/test_helper'

class SeedFollowingWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    columns = [:user_id, :following_id, :created_at, :updated_at]
    values = []

    followings = ( User.ids - [ test_user.id ] ).sample( number )
    followings.each do |f|
      values << %Q[
        (#{f}, #{test_user.id}, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      ]
    end

    ActiveRecord::Base.connection.execute(
      "INSERT INTO follows (#{columns.join(',')}) VALUES #{values.join(',')}"
    )
  end
end
