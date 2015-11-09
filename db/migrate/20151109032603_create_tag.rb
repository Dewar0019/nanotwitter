class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.belongs_to :tweet, index: true
      t.string :tag

      t.timestamps null: false
    end
  end

  def down
    drop_table :tags
  end
end
