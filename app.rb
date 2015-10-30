require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'tilt/erb'
require 'require_all'
require 'fabrication'
require 'pry'
require 'sinatra/flash'
require 'digest/md5'
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
    user.id = session[:user_id]
  end

  def login?
    session.key?(:user_id)
  end

  def logout
    session.delete(:user_id)
  end

  def link_to(link_name, url)
    "<a href=#{url}> #{link_name} </a>"
  end

  def h(text)
    Rack::Utils.escape_html(text)
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
  u = User.find_by_email(params[:email])
  if u and u.authenticate(params[:password])
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
  new_user = User.new(params)
  if new_user.save
    login(new_user)
    redirect '/'
  else
    flash[:notice] = "Error in signup"
    redirect '/signup'
  end
end

get '/users/:id' do
  @tweets = Tweet.recent(50, [ params[:id] ])
  email_address = User.find_by(id: params[:id])
  email_address =email_address.email
  hash = Digest::MD5.hexdigest(email_address)
  @image_src = "http://www.gravatar.com/avatar/#{hash}"
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




## Test Interface ##

get '/test/reset' do
  test_params = {user_name: "test_user",
                 name:"test user",
                 password: "test123",
                 email: "testuser@test.com"}

  # destroy test_user if it exists
  test_user = User.find_by_user_name("test_user")
  test_user.destroy if test_user

  # create a new test_user
  test_user = User.create(test_params)

  redirect "/users/#{test_user.id}"
end

get '/test/seed/:number' do
  params[:number].to_i.times { Fabricate(:user) }
  redirect '/'
end

get '/test/tweets/:number' do
  test_user = User.find_by_user_name("test_user")
  params[:number].to_i.times { Fabricate(:tweet, user_id: test_user.id) }

  redirect "/users/#{test_user.id}"
end

get '/test/follow/:number' do
  test_user = User.find_by_user_name("test_user")

  # get array of all user_id then remove test_user.id from that array
  followings = ( User.ids - [ test_user.id ] ).sample( params[:number].to_i  )
  followings.each do |f|
    Follow.create(user_id: f, following_id: test_user.id)
  end

  redirect "/users/#{test_user.id}"
end
