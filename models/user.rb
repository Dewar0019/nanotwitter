class User < ActiveRecord::Base
  has_secure_password

  has_many :favorites, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :timelines, dependent: :destroy

  has_many :followings, class_name: 'Follow', foreign_key: 'user_id', dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy

  validates :name, presence: true
  validates :user_name, :email,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :password,
    presence: true,
    length: { minimum: 6 },
    on: :create

  before_save :downcase_fields

  scope :most_recent_updated, -> { order(updated_at: :desc).first }

  def downcase_fields
    self.user_name.downcase!
    self.email.downcase!
  end

  private :downcase_fields
end
