require 'sinatra/base'

module Sinatra
  module ApplicationHelpers
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
      user.id == session[:user_id]
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

    ##
    # user must login to continue
    # else redirect to /login
    def must_login
      return if login?
      flash[:notice] = "Please login or signup"
      redirect '/login'
    end

    ##
    # set last_modified header for a webpage
    def set_last_modified(obj)
      last_modified obj.updated_at
    end

    ##
    # set etag header for a webpage
    def set_etag(obj)
      etag Digest::MD5.hexdigest(obj.cache_key)
    end

    def search(search_term)
      $redis2.fetch(search_term + "/users/" + User.most_recent_updated.cache_key) do
        @users = User.where("user_name like? OR email like?", "%#{search_term}%", "%#{search_term}%")
      end
      $redis2.fetch(search_term + "/hashtags/" + Tweet.most_recent_updated.cache_key) do
        ids = Tag.where(tag: search_term).order(created_at: :desc).pluck(:tweet_id)
        @tweets = Tweet.includes(:user).where(id: ids).order(created_at: :desc)    
      end
      return @users, @tweets
    end

    def search_users_cache_key(search_term)
      search_term + "/users/" + User.most_recent_updated.cache_key
    end

    def search_hashtags_cache_key(search_term)
      search_term + "/hashtags/" + Tweet.most_recent_updated.cache_key
    end

  end
end

