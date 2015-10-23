require 'fabrication'

User.delete_all
Tweet.delete_all

100.times { Fabricate(:user) }
100.times { Fabricate(:tweet) }

# seed following
User.all.each do |u|
  random_number = rand(20)

  followings = (0..100).to_a.sample(random_number)
  followings.delete(u.id)

  followings.each do |f|
    Follow.create(user_id: u.id, following_id: f)
  end
end

# seed retweet and favorite
Tweet.all.each do |t|
  random_number = rand(20)

  retweeters = (0..100).to_a.sample(random_number)
  retweeters.delete(t.user_id)

  favorites = (0..100).to_a.sample(random_number)
  favorites.delete(t.user_id)

  retweeters.each do |r|
    Retweet.create(tweet_id: t.id, user_id: r)
  end

  favorites.each do |f|
    Favorite.create(tweet_id: t.id, user_id: f)
  end
end
