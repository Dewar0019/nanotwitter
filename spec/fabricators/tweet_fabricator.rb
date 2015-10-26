require 'faker'

Fabricator(:tweet) do
  text { Faker::Lorem.characters(140) }
  user_id { rand(User.count) +1 }
end
