class CreateFollow < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.belongs_to :user, index: true
      t.integer :following_id, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :follows
  end
end
