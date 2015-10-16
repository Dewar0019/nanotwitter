class CreateUser < ActiveRecord::Migration
  def change
  	create_table :users do |t|   #has to be plural "users"
   		t.string :user_name
  		t.string :first_name
  		t.string :last_name
  		t.string :email
  		t.string :password
  		t.boolean :gender

  		t.timestamps null: false
  	end
  end
end
