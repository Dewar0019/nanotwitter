require 'sinatra/base'
require 'readthis'

module Sinatra
  module CacheHelpers
    def cache
      redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
      @cache ||= Readthis::Cache.new(
        expires_in: 2.weeks.to_i,
        redis: { url: redis_url, driver: :hiredis }
      )
    end
  end
end
