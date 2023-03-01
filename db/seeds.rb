# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "open-uri"


puts "Database cleaning..."
Game.destroy_all
User.destroy_all

puts "Import seeds in database..."

owner = User.create(first_name: "Tom", last_name: "Lewis", email: "tom.lewis@test.com", password: "azerty", username: "tom_lewis", city: "Toulouse", street_number: "39 allée Jules Guedes", postal_code: "31000")
User.create(first_name: "Michel", last_name: "Baillard", email: "michel.baillard@test.com", password: "azerty", username: "michel_b", city: "Blagnac", street_number: "20 place centrale", postal_code: "31700")

games_attr = [
  {
    attributes: { name: "Catan", address: "14 rue louis plana, Toulouse", price_per_day: 5, minimum_age: 8, players: 4, description: "game of management and strategy" },
    photo: "http://dungeonmarvels.com/25055-large_default/los-colonos-de-catan.jpg"
  },
  {
    attributes: { name: "Uno", address: "place du capitole, Toulouse", price_per_day: 3, minimum_age: 5, players: 8, description: "game of cards" },
    photo: "https://cdn.playtherapysupply.com/img/f/b799cadd80a5.jpg"
  },
  {
    attributes: { name: "Perudo", address: "rue de la colombette, Toulouse", price_per_day: 4, minimum_age: 6, players: 6, description: "similar to poker with dices" },
    photo: "http://www.jeuxdenim.be/images/jeux/Perudo_large01.jpg"
  },
  {
    attributes: { name: "Monopoly", address: "place des carmes, toulouse", price_per_day: 8, minimum_age: 7, players: 4, description: "very popular" },
    photo: "https://isolationmuseum.com/wp-content/uploads/2020/04/IMG_8200-scaled.jpg"
  }
]

games_attr.each do |game_attr|
  sleep(1)
  game = Game.new(game_attr[:attributes])
  game.user = owner
  file = URI.open(game_attr[:photo])
  game.photos.attach(io: file, filename: "#{game_attr[:attributes][:name]}.jpg", content_type: "photo.jpg")
  game.save!
end

puts "Import in database finished"
