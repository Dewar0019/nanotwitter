require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'

require 'rake/testtask'

require './config/environments' # database configuration

require 'tilt/erb'

require 'require_all'
require_all './models'
require_all './controllers'

Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

class NanoTwitter < Sinatra::Base
  use HomepageController
  use SessionController
  use TestController
  use TweetController
  use UserController

  not_found do
    status 404
    "The page you requested doesn't exist"
  end

  error 500 do
    "Internal error"
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
