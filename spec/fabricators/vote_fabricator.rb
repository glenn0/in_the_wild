Fabricator(:vote) do
  creator { Faker::Name.first_name }
  email { Faker::Internet.email }
  password 'password'
  admin false
  locked false
end