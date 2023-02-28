# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
owner = User.create!(first_name: "Tom", last_name: "Lewis", email: "tom.lewis@test.com", password: "azerty", username: "tom_lewis", city: "Toulouse", street_number: "39 allée Jules Guedes", postal_code: "31000")
User.create!(first_name: "Michel", last_name: "Baillard", email: "michel.baillard@test.com", password: "azerty", username: "michel_b", city: "Blagnac", street_number: "20 place centrale", postal_code: "31700")

games_attr = [
  { name: "Catan", city: "Toulouse", price_per_day: 5, minimum_age: 8, players: 4, description: "game of management and strategy" },
  { name: "Uno", city: "Bordeaux", price_per_day: 3, minimum_age: 5, players: 8, description: "game of cards" },
  { name: "Perudo", city: "Toulouse", price_per_day: 4, minimum_age: 6, players: 6, description: "similar to poker with dices", user: owner },
  { name: "Monopoly", city: "Paris", price_per_day: 8, minimum_age: 7, players: 4, description: "very popular", user: owner }
]

games_attr.each do |game_attr|
  game = Game.new(game_attr)
  game.user = owner
  game.save
end
