class SeedWorker
  include Sidekiq::Worker

  def perform(number)
    number.times { Fabricate(:user) }
  end
end
