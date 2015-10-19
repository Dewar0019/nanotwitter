class CreateUser < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :user_name
      t.string :email
      t.string :password
      t.integer :tweets_count
      t.integer :followers_count
      t.integer :followings_count

      t.timestamps null: false
    end
  end

  def down
    drop_table :users
  end
end
