require 'readthis'

module DatabaseCacheHelpers
  def my_cache
    redis_url = ENV['HEROKU_REDIS_JADE_URL'] || 'redis://localhost:6379/1'
    @my_cache ||= Readthis::Cache.new(
      expires_in: 2.weeks.to_i,
      redis: { url: redis_url, driver: :hiredis }
    )
  end
end
