require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Deflater
use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 600, # 10 mins
                           :secret => ENV['SECRET'] || 'super_secret'

redis_url = ENV['REDIS_URL'] || 'redis://localhost:6379'
use Rack::Cache,
  verbose: true,
  metastore: redis_url,
  entitystore: redis_url

require './app'
run NanoTwitter
