class CreateReply < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      belongs_to :tweet, index: true
      belongs_to :user, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :replies
  end
end
