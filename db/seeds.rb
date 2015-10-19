require 'fabrication'


100.times { Fabricate(:user) }
100.times { Fabricate(:tweet) }
