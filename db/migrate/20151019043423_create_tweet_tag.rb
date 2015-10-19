class CreateTweetTag < ActiveRecord::Migration
  def change
    create_table :tweet_tags do |t|
      belongs_to :tweet, index: true
      belongs_to :tag, index: true
    end
  end

  def down
    drop_table :tweet_tags
  end
end
