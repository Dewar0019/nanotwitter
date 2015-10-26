require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'tilt/erb'
require 'require_all'
require_all './models'

after { ActiveRecord::Base.connection.close }

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'super_secret'

helpers do
  def user
    @user ||= User.find_by(id: params[:id]) || halt(404)
  end

  ##
  # save user_id to session
  def login(user)
    session[:user_id] = user.id
  end

  ##
  # return current logged in user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  ##
  # returns true if given user is the current user
  def current_user?(user)
    user == current_user
  end

  def login?
    !current_user.nil?
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end

  def link_to(link_name, url)
    "<a href=#{url}>#{link_name}</a>"
  end

  ##
  # returns true if current user already follows user
  def already_follow?(user)
    !Follow.find_by(user_id: current_user.id, following_id: user.id).nil?
  end
end

not_found do
  status 404
  erb :error
end

get '/' do
  if login?
    user_ids = current_user.followings.pluck(:following_id) << current_user.id
    # tweets by user and their following
    @tweets = Tweet.recent(50, user_ids)
  else
    @tweets = Tweet.recent(50)
  end
  erb :index
end

get '/login' do
  if login?
    redirect '/'
  else
    erb :login
  end
end

post '/login' do
  u = User.find_by(email: params[:email])
  if u and u.password == params[:password]
    login(u)
    redirect '/'
  else
    "Wrong password or user doesn't exists"
  end
end

# fake login to user_id
get '/login/:id' do
  login(user)
  redirect '/'
end

get '/logout' do
  logout
  redirect "/"
end

get '/signup' do
  erb :signup
end

post '/signup' do
  new_user = User.new(user_name: params[:user_name], password: params[:password], email: params[:email])
  if new_user.save
    login(new_user)
    redirect '/'
  else
    "Error"
  end
end

get '/users/:id' do
  @tweets = Tweet.recent(50, [ params[:id] ])
  erb :users
end

get '/users/:id/followings' do
  erb :followings
end

get '/users/:id/followers' do
  erb :followers
end

# current user follows user_id
post '/users/:id/followers/new' do
  new_follow = Follow.new(user_id: session[:user_id], following_id: params[:id])

  if new_follow.save
    redirect "/users/#{params[:id]}"
  else
    "Error"
  end
end

post '/users/:id/followers/delete' do
  follow = Follow.find_by(user_id: session[:user_id], following_id: params[:id])
  Follow.destroy(follow.id)
  redirect "/users/#{params[:id]}"
end

post '/tweets/new' do
  new_tweet = Tweet.new(user_id: session[:user_id], text: params[:tweet])

  if new_tweet.save
    redirect '/'
  else
    "Error"
  end
end
