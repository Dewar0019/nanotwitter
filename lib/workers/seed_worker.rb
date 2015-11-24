require "activerecord-import/base"

class SeedWorker
  include Sidekiq::Worker

  def perform(number)
    users = []
    number.times { users << Fabricate.build(:user) }

    User.import users, :validate => false
  end
end
