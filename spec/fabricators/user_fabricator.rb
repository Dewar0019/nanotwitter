require 'faker'

Fabricator(:user) do
  name { Faker::Name.name }
  user_name { Faker::Internet.user_name + Faker::Number.number(3) }
  email { Faker::Internet.email }
  bio { Faker::Company.buzzword }
  password { Faker::Internet.password(8) }
end
