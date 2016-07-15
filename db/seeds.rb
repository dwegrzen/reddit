# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = 100.times.map do
  User.create!(username: Faker::Internet.user_name)
end

subreddits = 25.times.map do
    Subreddit.create!(
    name: Faker::Book.title
    )
end

links = 473.times.map do
  Link.create!(
    title: Faker::ChuckNorris.fact,
    user: users.sample,
    summary: Faker::Hipster.sentences(2).join(" "),
    thumbnail: "https://unsplash.it/100/100",
    hyperlink: "http://www.randomusefulwebsites.com/jump.php",
    subreddit: subreddits.sample
    )
end
