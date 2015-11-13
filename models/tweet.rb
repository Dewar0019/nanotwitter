require './helpers/database_cache_helper'

class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true, touch: true

  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :tags, dependent: :destroy

  validates :text,
    presence: true,
    length: { minimum: 1, maximum: 140 }

  after_create :add_to_timeline_self, :add_to_timeline_followers

  class << self
    include DatabaseCacheHelpers

    ##
    # returns n recent tweets by user
    # if user is nil, returns n recent tweets
    def recent(n, user = nil)
      if user.nil?
        t = Tweet.order(updated_at: :desc).first
        my_cache.fetch(t) do
          Tweet.includes(:user).order(created_at: :desc).first(n)
        end
      else
        my_cache.fetch(user) do
          Tweet.includes(:user).where(user: user).order(created_at: :desc).first(n)
        end
      end
    end
  end

  ##
  # pretty print created time of a tweet
  # ie. 16 Oct 2015 22:17
  def pretty_print_date
    self.created_at.strftime("%-d %b %Y %H:%M")
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

  private :add_to_timeline_self, :add_to_timeline_followers
end
