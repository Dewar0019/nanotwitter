class CreateTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true
      t.string :text
      t.integer :retweets_count, default: 0
      t.integer :favorites_count, default: 0

      t.timestamps null: false, index: true
    end
  end

  def down
    drop_table :tweets
  end
end
