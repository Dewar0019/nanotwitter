class User < ActiveRecord::Base
  has_many :favorites, dependent: :destroy
  has_many :tweets, dependent: :destroy
  has_many :retweets, dependent: :destroy
  has_many :replies, dependent: :destroy

  has_many :followings, class_name: 'Follow', foreign_key: 'user_id', dependent: :destroy
  has_many :followers, class_name: 'Follow', foreign_key: 'following_id', dependent: :destroy

  validates :user_name, :email,
    presence: true,
    uniqueness: { case_sensitive: false }
  validates :password,
    presence: true,
    length: { minimum: 6 }

  before_save :downcase_fields

  def downcase_fields
    self.user_name.downcase!
    self.email.downcase!
  end

  private :downcase_fields
end
