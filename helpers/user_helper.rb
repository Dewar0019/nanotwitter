require 'sinatra/base'

module Sinatra
  module UserHelpers
    def gravatar_url(user)
      hash = Digest::MD5.hexdigest(user.email)
      return "http://www.gravatar.com/avatar/#{hash}"
    end

    def followers_list_cache_key
      "followers/#{user.cache_key}"
    end

    def followings_list_cache_key
      "followings/#{user.cache_key}"
    end
  end
end
