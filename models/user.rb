class User < ActiveRecord::Base
  has_many :favorites
  has_many :tweets
  has_many :messages
  has_many :retweets
  has_many :replies

  validates :user_name, :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }

  before_save :downcase_fields

  def downcase_fields
    self.user_name.downcase!
    self.email.downcase!
  end

  private :downcase_fields
end
