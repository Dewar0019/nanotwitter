class CreateFavorite < ActiveRecord::Migration
  def change
    create_table :favorites do |t|
      t.belongs_to :tweet, index: true
      t.belongs_to :user, index: true
    end
  end

  def down
    drop_table :favorites
  end
end
