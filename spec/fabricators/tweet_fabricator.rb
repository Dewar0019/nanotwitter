require 'faker'

Fabricator(:tweet) do
  text { Faker::Company.catch_phrase }
  user_id { rand(User.count) +1 }
end
