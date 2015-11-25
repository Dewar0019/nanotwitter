web: bundle exec puma -C config/puma.rb
worker: bundle exec sidekiq -q default -c 6 -r ./app.rb
