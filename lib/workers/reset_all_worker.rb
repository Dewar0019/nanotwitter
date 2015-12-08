require './helpers/test_helper'

class ResetAllWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform
    Sidekiq::Queue.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::RetrySet.new.clear

    User.delete_all
    Follow.delete_all
    Tweet.delete_all
    $redis1.clear
    $redis2.clear
    $redis3.flushdb

    create_new_test_user
  end
end
