require 'fabrication'

User.delete_all
Tweet.delete_all

100.times { Fabricate(:user) }
100.times { Fabricate(:tweet) }
