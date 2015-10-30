require 'sinatra/activerecord'

post '/tweets/new' do
  new_tweet = Tweet.new(user_id: session[:user_id], text: params[:tweet])
  if new_tweet.save
    redirect '/'
  else
    "Error"
  end
end
