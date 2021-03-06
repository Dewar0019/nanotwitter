require './helpers/application_helper'
require './helpers/cache_helper'

class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../../views', __FILE__)
  set :public_folder, File.expand_path('../../public', __FILE__)
  set :static_cache_control, [:public, max_age: 86400]

  helpers Sinatra::ApplicationHelpers
  helpers Sinatra::CacheHelpers

  register Sinatra::Flash

  before { cache_control :public, :must_revalidate, :max_age => 0 }
  after { ActiveRecord::Base.connection.close }

  get '/search' do
    @users, @tweets = search(params[:search_term])
    erb :search_results
  end

end
