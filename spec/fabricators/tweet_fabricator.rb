require 'faker'

Fabricator(:tweet) do
  text { Faker::Lorem.characters(140) }
  user_id { rand(100) }
end
