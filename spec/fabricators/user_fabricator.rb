Fabricator(:user) do
  username { Faker::Internet.user_name }
  email { Faker::Internet.email }
  password 'password'
  full_name { Faker::Name.name}
  admin false
end

Fabricator(:admin, from: :user) do
  admin true
end