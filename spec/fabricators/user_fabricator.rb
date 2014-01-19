Fabricator(:user) do
  username { Faker::Name.first_name }
  email { Faker::Internet.email }
  password 'password'
  admin false
  locked false
end

Fabricator(:admin, from: :user) do
  admin true
end