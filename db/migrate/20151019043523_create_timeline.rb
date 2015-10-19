class CreateTimeline < ActiveRecord::Migration
  def change
    create_table :timelines do |t|
      belongs_to :tweet, index: true
      belongs_to :user, index: true
    end
  end

  def down
    drop_table :timelines
  end
end
