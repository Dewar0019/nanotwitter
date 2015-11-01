class CreateTimeline < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      t.belongs_to :tweet, index: true
      t.belongs_to :user, index: true

      t.timestamps null: false
    end
  end

  def down
    drop_table :timelines
  end
end
