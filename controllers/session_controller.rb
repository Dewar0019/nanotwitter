class SessionController < ApplicationController
  get '/login' do
    redirect '/' if login?
    erb :login
  end

  post '/login' do
    u = User.find_by_email(params[:email])
    if u and u.authenticate(params[:password])
      login(u)
      redirect '/'
    else
      flash[:notice] = "Wrong password or user doesnot exists"
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
end
