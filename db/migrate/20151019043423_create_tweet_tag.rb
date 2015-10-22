class CreateTweetTag < ActiveRecord::Migration
  def change
    create_table :tweet_tags do |t|
      t.belongs_to :tweet, index: true
      t.string :tag
    end
  end

  def down
    drop_table :tweet_tags
  end
end
