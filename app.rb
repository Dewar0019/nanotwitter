require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' # database configuration
require 'require_all'
require_all './models'


enable :sessions

helpers do

	def login? 
		!(session[:email].nil?)
	end

end


get '/' do
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


