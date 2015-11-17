## 0.4.0 (2015-11-16)

Features:

  - Setup Loader.io and Newrelic
  - Name column in User table must not be empty
  - Add bio, favorites_count and retweets_count columns to User table
  - User profile on a navbar similar to Twitter
  - Use puma as default web server
  - Set ruby version to 2.2.3 in Gemfile
  - Add a Procfile for Heroku
  - Referential integrity constraint for tweet foreign key
  - Add tweets to a new follower's timeline
  - Use Redis as caching backend for HTTP caching, fragment caching and database query caching
  - Rack::Session::Cookie will use enviroment variable SECRET if found
  - HTTP caching for homepage if not logged in
  - Increase number of tweets shown per page to 100
  - Expire cookie after 5 minutes

Bugfixes:

  - User in unit tests have name attribute
  - Order tweets by most recent created date
  - Change TweetTag table to Tag table


Cleanup:

  - Remove unused images
  - Remove byebug in Gemfile

## 0.3.0 (2015-11-03)

Features:

  - Unit tests
  - Logged in users can favorite or retweet a tweet
  - Favorite and retweet pages for each user
  - Test interface to quickly generate tweets and followings for testuser
  - Setup [Codeship](https://codeship.com/projects/112764)
  - Setup [Heroku](http://smalltwitter.herokuapp.com/)
  - Password is encrypted using bcrypt gem
  - Update README with setup, Codeship badge and license
  - User avatar, using [Gravatar](https://en.gravatar.com/)
  - Timeline table
  - Tweets created by self and followings are stored in Timeline
  - Error 404, 500 handling
