require 'sinatra/base'
require './helpers/application_helper'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  use Rack::Session::Cookie, :key => 'rack.session',
                             :path => '/',
                             :expire_after => 2592000, # In seconds
                             :secret => 'super_secret'

  after { ActiveRecord::Base.connection.close }

  helpers Sinatra::ApplicationHelpers
  register Sinatra::Flash
end
