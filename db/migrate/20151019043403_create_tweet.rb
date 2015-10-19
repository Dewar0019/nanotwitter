class CreateTweet < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.belongs_to :user, index: true
      t.string :text
    end
  end

  def down
    drop_table :tweets
  end
end
