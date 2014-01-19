Fabricator(:project) do
  url { Faker::Internet.url }
  name { Faker::Lorem.words }
  description { Faker::Lorem.sentences(sentence_count: 2) }
end