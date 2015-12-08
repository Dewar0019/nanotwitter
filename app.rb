require 'bundler'
require 'rake/testtask'
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


  Rake::TestTask.new do |t|
    t.libs << "test"
    t.test_files = FileList['test/integration/test.rb','test/unit/user_test.rb','test/unit/authentication_test.rb','test/unit/test_interface_test.rb','test/unit/timeline_test.rb','test/unit/tweet_test.rb']
    t.verbose = true
  end

end
