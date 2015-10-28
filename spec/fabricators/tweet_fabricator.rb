require 'faker'

Fabricator(:tweet) do
  text { Faker::Company.catch_phrase }
  user_id { User.ids.sample }
end
