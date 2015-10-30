require 'sinatra/activerecord'

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
    flash[:notice] = "Wrong password or user doesn't exists"
    redirect '/login'
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
