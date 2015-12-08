class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true, touch: true

  has_many :favorites, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :timelines, dependent: :destroy

  validates :text,
    presence: true,
    length: { minimum: 1, maximum: 140 }

  after_create :add_to_timeline_self, :add_to_timeline_followers, :add_to_tags_table

  scope :most_recent_updated, -> { order(updated_at: :desc).first }

  class << self
    ##
    # returns n recent tweets by user
    # if user is nil, returns n recent tweets
    def recent(n, user = nil)
      if user.nil?
        $redis2.fetch(Tweet.most_recent_updated) do
          Tweet.includes(:user).order(created_at: :desc).first(n)
        end
      else
        $redis2.fetch(user) do
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

  def add_to_tags_table
    tags = Tag.extract_hashtags(self.text)
    if !tags.empty?
      tags.each do |tag|
        Tag.create(tag: tag, tweet: self)
      end
    end
  end

  private :add_to_timeline_self, :add_to_timeline_followers
end
