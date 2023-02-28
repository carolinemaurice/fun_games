# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "COUCOU"
Game.create(name: "Catan", city: "Toulouse", price_per_day: 5, minimum_age: 8, players: 4)
Game.create(name: "Uno", city: "Bordeaux", price_per_day: 3, minimum_age: 5, players: 8)
Game.create(name: "Perudo", city: "Toulouse", price_per_day: 4, minimum_age: 6, players: 6)
Game.create(name: "Monopoly", city: "Paris", price_per_day: 8, minimum_age: 7, players: 4)

puts "FINI"
