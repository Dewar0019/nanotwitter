require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'tilt/erb'
require 'require_all'
require 'fabrication'
require 'pry'
require_all './models'

use Rack::Session::Cookie, :key => 'rack.session',
                           :path => '/',
                           :expire_after => 2592000, # In seconds
                           :secret => 'super_secret'

helpers do   

  def login? #Checks if user is currently logged in
    !(session[:email].nil?)
  end

end


get '/' do
  @recent_tweets = Tweet.order(created_at: :desc).first(100)
  erb :index
end

get '/login' do
  erb :login
end

post '/login' do
  if User.exists?(email: params[:email])
    @user = User.find_by(email: params[:email])
    if @user.password == params[:password]
      session[:email] = params[:email]
      redirect '/'
    end
  end
  erb :error
end

get '/logout' do
  session[:email] = nil
  redirect "/"
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.create(user_name: params[:user_name], password: params[:password], email: params[:email])
  if user.save
    session[:email] = params[:email]
    redirect '/'
  end
  erb :error
end

get '/users' do
  @users = User.all
  erb :users
end

get '/test/reset' do
  User.delete_all
  Tweet.delete_all
  User.create(user_name: "testuser", password: "test123", email: "testuser@test.com")
  redirect '/'
end

get '/test/seed/:number' do
  params[:number].to_i.times { Fabricate(:user) }
  redirect '/users'
end

get '/test/tweets/:number' do
  params[:number].to_i.times { Fabricate(:tweet) }
  redirect '/'
end

get '/test/follow/:number' do
  number = params[:number].to_i
  test_user = User.find(user_name: "testuser")
  # seed following
  random_number = rand(number)
  followings = (0...User.size).to_a.sample(random_number)  #creates an array of random follower_ids
  followings.delete(test_user.id)  #cannot follow itself meaning test user so delete if it appears
  followings.each do |f|  
    Follow.create(user_id: test_user.id, following_id: f)
  end
    redirect '/'
end






