require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'require_all'
require_all './models'


get '/' do #form for person
	@user = User.all
	erb :index
end
