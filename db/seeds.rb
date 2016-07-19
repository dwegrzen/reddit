# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = 30.times.map do
  User.create!(
  username: Faker::Internet.user_name,
  password: "password",
  email: Faker::Internet.email,
  bio: Faker::Lorem.sentence
  )
end

subreddits = 20.times.map do
    Subreddit.create!(
    name: Faker::Superhero.power
    )
end

links = 200.times.map do
  Link.create!(
    title: Faker::ChuckNorris.fact,
    user: users.sample,
    summary: Faker::Hipster.sentences(2).join(" "),
    thumbnail: "https://unsplash.it/100/100/?image=#{rand(1000)}",
    hyperlink: "http://www.randomusefulwebsites.com/jump.php",
    subreddit: subreddits.sample
    )
end


votes = 1000.times.map do
  Vote.create!(
  value: rand(0..1) * 2 - 1,
  user: users.sample,
  link: links.sample
  )
end
