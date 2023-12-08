require 'faker'

20.times do
  Blog.create(
    title: Faker::Lorem.sentence(word_count: 3),
    content: Faker::Lorem.paragraph(sentence_count: 5)
  )
end

User.create(
  email: Faker::Internet.email,
  password: 'password'  
)

p 'successfully created data.'