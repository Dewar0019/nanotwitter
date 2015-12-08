class CreateFavorite < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :tweet
      t.belongs_to :user, index: true

      t.timestamps null: false, index: true
    end
  end

  def down
    drop_table :favorites
  end
end
