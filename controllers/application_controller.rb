require 'sinatra/base'
require 'sinatra/partial'
require './helpers/application_helper'
require './helpers/cache_helper'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  helpers Sinatra::ApplicationHelpers
  helpers Sinatra::CacheHelpers

  register Sinatra::Flash
  register Sinatra::Partial
  set :partial_template_engine, :erb

  before { cache_control :public, :must_revalidate, :max_age => 0 }
  after { ActiveRecord::Base.connection.close }
end
