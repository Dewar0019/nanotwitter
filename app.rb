require 'bundler'
Bundler.require

require './config/environments'

require 'tilt/erubis'

require_all './models'
require_all './controllers'

class NanoTwitter < Sinatra::Base
  use HomepageController
  use SessionController
  use TestController
  use TweetController
  use UserController
  use APIController

  not_found do
    "The page you requested doesn't exist"
  end

  error 404, ActiveRecord::RecordNotFound do
    not_found
  end

  error 500 do
    "Internal error"
  end
end
