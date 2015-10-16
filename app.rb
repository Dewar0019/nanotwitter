require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'require_all'
require_all './models'


get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/signup' do
  erb :signup
end

get '/users' do
  @users = User.all
  erb :users
end