class CreateFollow < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      belongs_to :user, index: true
      belongs_to :follow, class_name: "User", index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :follows
  end
end