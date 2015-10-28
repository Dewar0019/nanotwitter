require 'fabrication'

100.times { Fabricate(:user) } #creates 100 users
100.times { Fabricate(:tweet) } #creates 100 random tweets

# seed following
User.all.each do |u|
  followings = ( User.ids - [ u.id ] ).sample(rand(20))  #creates an array of random follower_ids
  followings.each do |f|
    Follow.create(user_id: u.id, following_id: f)
  end
end

# seed retweet and favorite
Tweet.all.each do |t|
  retweeters = ( User.ids - [ t.user_id ] ).sample( rand(20) )
  retweeters.each do |r|
    Retweet.create(tweet_id: t.id, user_id: r)
  end

  favorites = ( User.ids - [ t.user_id ] ).sample( rand(20) )
  favorites.each do |f|
    Favorite.create(tweet_id: t.id, user_id: f)
  end
end
