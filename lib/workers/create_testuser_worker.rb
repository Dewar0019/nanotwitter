require './helpers/test_helper'

class CreateTestuserWorker
  include Sidekiq::Worker
  include Sinatra::TestHelpers

  def perform
    test_user.destroy if test_user
    create_new_test_user()
  end
end
