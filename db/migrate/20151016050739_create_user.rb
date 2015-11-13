class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_name
      t.string :email
      t.string :bio
      t.string :password_digest
      t.integer :tweets_count, default: 0
      t.integer :followers_count, default: 0
      t.integer :followings_count, default: 0
      t.integer :retweets_count, default: 0
      t.integer :favorites_count, default: 0

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
