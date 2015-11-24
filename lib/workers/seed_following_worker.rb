require './helpers/test_helper'
require "activerecord-import/base"

class SeedFollowingWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform(number)
    columns = [:user_id, :following_id]
    values = []

    followings = ( User.ids - [ test_user.id ] ).sample( number )

    followings.each do |f|
      values << [f, test_user.id]
    end

    Follow.import columns, values
  end
end
