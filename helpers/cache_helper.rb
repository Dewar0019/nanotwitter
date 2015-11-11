require 'sinatra/base'
require 'readthis'

module Sinatra
  module CacheHelpers
    def my_cache
      redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
      @my_cache ||= Readthis::Cache.new(
        expires_in: 2.weeks.to_i,
        redis: { url: redis_url, driver: :hiredis }
      )
    end

    def cache(name, &block)
      if my_cache.exist?(name)
        @_out_buf << my_cache.read(name)
      else
        temp = block.call
        my_cache.write(name, temp)
        temp
      end
    end
  end
end
