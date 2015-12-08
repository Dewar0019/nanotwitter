class CreateRetweet < ActiveRecord::Migration
  def change
    create_table :retweets do |t|
      t.belongs_to :tweet
      t.belongs_to :user, index: true

      t.timestamps null: false, index: true
    end
  end

  def down
    drop_table :retweets
  end
end
