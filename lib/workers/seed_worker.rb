require "activerecord-import/base"

class SeedWorker
  include Sidekiq::Worker

  def perform(number)
    columns = [:name, :user_name, :email, :bio, :password_digest, :created_at, :updated_at]
    values = []

    number.times do
      values << %Q[
        ('#{Faker::Name.name}',
        '#{Faker::Internet.user_name}#{Faker::Number.number(3)}',
        '#{Faker::Internet.email}', '#{Faker::Company.buzzword}',
        '#{BCrypt::Password.create(Faker::Internet.password(8))}',
        CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)
      ]
    end

    ActiveRecord::Base.connection.execute(
      "INSERT INTO users (#{columns.join(',')}) VALUES #{values.join(',')}"
    )
  end
end
