# redis1 used for fragment caching
url1 = ENV['REDIS_URL'] || 'redis://localhost:6379/1'
$redis1 = Readthis::Cache.new(
  expires_in: 2.weeks.to_i,
  redis: { url: url1, driver: :hiredis }
)

# redis2 used for database query caching
url2 = ENV['HEROKU_REDIS_JADE_URL'] || 'redis://localhost:6379/2'
$redis2 = Readthis::Cache.new(
  expires_in: 2.weeks.to_i,
  redis: { url: url2, driver: :hiredis }
)

# redis3 for sidekiq
url3 = ENV['HEROKU_REDIS_BLACK_URL'] || 'redis://localhost:6379/0'
$redis3 = Redis.new(url: url3, driver: :hiredis)

configure :production do
  require 'newrelic_rpm'

  puts "[production environment]"

  db = URI.parse(ENV['DATABASE_URL'] || 'postgres://localhost/mydb')

  ActiveRecord::Base.establish_connection(
      :adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
      :host     => db.host,
      :username => db.user,
      :password => db.password,
      :database => db.path[1..-1],
      :encoding => 'utf8'
  )
end

configure :development, :test do
  puts "[develoment or test Environment]"
end
