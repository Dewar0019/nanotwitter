class CreateTag < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :tag
    end
  end

  def down
    drop_table :tags
  end
end
