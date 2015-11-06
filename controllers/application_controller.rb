require 'sinatra/base'
require './helpers/application_helper'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)

  helpers Sinatra::ApplicationHelpers
  register Sinatra::Flash
end
