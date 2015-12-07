require './helpers/test_helper'

class ResetAllWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform
    Sidekiq::Queue.new.clear
    Sidekiq::ScheduledSet.new.clear
    Sidekiq::RetrySet.new.clear

    User.destroy_all
    Follow.destroy_all

    create_new_test_user
  end
end
