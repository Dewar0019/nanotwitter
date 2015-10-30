require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'tilt/erb'
require 'require_all'
require 'sinatra/flash'
require 'rake/testtask'
require_all './routes'
require_all './models'
require './helpers/usersession'

include UserSession


after { ActiveRecord::Base.connection.close }

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'super_secret'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end
