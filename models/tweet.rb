require './helpers/cache_helper'

class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true

  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :text,
    presence: true,
    length: { minimum: 1, maximum: 140 }

  after_create :add_to_timeline_self, :add_to_timeline_followers, :update_cache

  include Sinatra::CacheHelpers
  class << self
    ##
    # returns n recent tweets by user
    # if user is nil, returns n recent tweets
    include Sinatra::CacheHelpers
    def recent(n, user = nil)
      if user.nil?
        cache.fetch("homepage") do
          Tweet.includes(:user).order(created_at: :desc).first(n)
        end
      else
        cache.fetch("user:#{user.id}") do
          Tweet.includes(:user).where(user: user).order(created_at: :desc).ids.first(n)
        end
      end

      #Tweet.includes(:user).where(id: ids).order(created_at: :desc)
    end
  end

  ##
  # pretty print created time of a tweet
  # ie. 16 Oct 2015 22:17
  def pretty_print_date
    self.created_at.strftime("%-d %b %Y %H:%M")
  end

  def update_cache
    homepage_tweets = Tweet.includes(:user).order(created_at: :desc).first(50)
    cache.write("homepage", homepage_tweets)

    user_tweets = Tweet.includes(:user).where(user: user).order(created_at: :desc).first(50)
    cache.write("user:#{user_id}", user_tweets)
  end

  ##
  # add to self's timeline everytime user creates a new tweet
  def add_to_timeline_self
    Timeline.create(tweet: self, user: self.user)
  end

  ##
  # add to followers' timeline everytime user creates a new tweet
  def add_to_timeline_followers
    self.user.followers.each do |follower|
      Timeline.create(tweet: self, user: follower.user)
    end
  end

  private :add_to_timeline_self, :add_to_timeline_followers, :update_cache
end
