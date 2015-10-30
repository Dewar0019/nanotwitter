set :root, File.dirname(__FILE__)
require File.join(:root, 'app.rb')

run Sinatra::Application
