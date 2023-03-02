# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

require "open-uri"
require "faker"

Faker::Config.locale = 'fr'

puts "Database cleaning..."
Game.destroy_all
User.destroy_all

puts "Create users..."

address = [
  { street_number: "61 rue Pomme", postal_code: 31000, city: "Toulouse" },
  { street_number: "41 impasse Flambère", postal_code: 31300, city: "Toulouse" },
  { street_number: "23 r François Villon", postal_code: 31700, city: "Blagnac" },
  { street_number: "200 quai Jemmapes", postal_code: 75010, city: "Paris" },
  { street_number: "8 rue Maublanc", postal_code: 75015, city: "Paris" },
  { street_number: "30 rue Bas Longchamps", postal_code: 92220, city: "Bagneux" },
  { street_number: "7 quai Brazza", postal_code: 33100, city: "Bordeaux" },
  { street_number: "68 avenue Gaston Cabannes", postal_code: 33270, city: "Floirac" },
  { street_number: "38 rue Coulmiers", postal_code: 44000, city: "Nantes" },
  { street_number: "410 route Clisson", postal_code: 44120, city: "Vertou" },
  { street_number: "8 place Célestins", postal_code:  69002, city: "Lyon" },
  { street_number: "16 boulevard Jean Aicard", postal_code: 13005, city: "Marseille" },
  { street_number: "10 rue Gloriette", postal_code: 84000, city: "Avignon" }
]

new_address = address.sample
User.create!(
  first_name: "Tom",
  last_name: "Lewis",
  email: "tom.lewis@test.com",
  password: "azerty",
  username: "tom_lewis",
  city: new_address[:city],
  street_number: new_address[:street_number],
  postal_code: new_address[:postal_code]
)
new_address = address.sample
User.create!(
  first_name: "Michel",
  last_name: "Baillard",
  email: "michel.baillard@test.com",
  password: "azerty",
  username: "michel_b",
  city: new_address[:city],
  street_number: new_address[:street_number],
  postal_code: new_address[:postal_code]
)
20.times do
  sleep(1)
  new_address = address.sample
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: "#{Faker::Name.first_name}_#{Faker::Name.last_name}@test.com",
    password: "azerty",
    username: "#{Faker::Name.first_name}_#{Faker::Name.last_name}",
    city: new_address[:city],
    street_number: new_address[:street_number],
    postal_code: new_address[:postal_code]
  )
  file = URI.open(Faker::Avatar.image)
  user.photo.attach(io: file, filename: "#{user.first_name}.png", content_type: "photo.png")
end

puts "Create games..."

price_per_days = (1..8).to_a
minimum_ages = (4..10).to_a

games = [
  { name: "Catan", players: 4, description: "Utilisez des ressources pour construire des routes et de nouvelles colonies.", photo: "http://dungeonmarvels.com/25055-large_default/los-colonos-de-catan.jpg" },
  { name: "Uno", players: 8, description: "Jeu de cartes", photo: "https://cdn.playtherapysupply.com/img/f/b799cadd80a5.jpg" },
  { name: "Perudo", players: 6, description: "Un jeu de bluff plein de rebondissements!", photo: "http://www.jeuxdenim.be/images/jeux/Perudo_large01.jpg" },
  { name: "Monopoly", players: 4, description: "Très connu!", photo: "https://isolationmuseum.com/wp-content/uploads/2020/04/IMG_8200-scaled.jpg" },
  { name: "7wonders", players: 5, description: "Devenez dirigeant d'une des 7 grandes cités du monde antique.", photo: "https://www.regledujeu.fr/wp-content/uploads/7wonders.jpg" },
  { name: "Break the code", players: 4, description: "Jeu de déduction et de logique.", photo: "https://www.ludifolie.com/10481-thickbox_default/break-the-code.jpg" },
  { name: "Splendor", players: 4, description: "Dirigez une guilde de marchands.", photo: "http://www.dadsgamingaddiction.com/wp-content/uploads/2014/12/1SR.jpg" },
  { name: "6 qui prend", players: 10, description: "Jeu de cartes", photo: "https://www.gigamic.com/files/catalog/products/images/product-zoom/gigamic_amsixq_six-qui-prend_box-left.jpg" },
  { name: "Takenoko", players: 4, description: "Cultivez une plantation de bambou pour un panda", photo: "http://www.techartgeek.com/images/2014/03/Scanner-25-mars-2014-10_11-page2.jpg" },
  { name: "Just desserts", players: 5, description: "Les clients sont là, et ils ont faim. Alors tentez d’être le meilleur serveur du café.", photo: "https://www.espritjeu.com/upload/image/desserts-parfaits-p-image-62382-grande.jpg" },
]

50.times do
  sleep(1)
  user = User.all.sample
  game = games.sample
  attributes = { name: game[:name],
                 address: "#{user.street_number} #{user.postal_code} #{user.city}",
                 price_per_day: price_per_days.sample,
                 minimum_age: minimum_ages.sample,
                 players: game[:players],
                 description: game[:description]
               }
  photo = game[:photo]
  new_game = Game.new(attributes)
  new_game.user = user
  file = URI.open(photo)
  new_game.photos.attach(io: file, filename: "#{game[:name]}.jpg", content_type: "photo.jpg")
  new_game.save!
end

puts "Create bookings..."

30.times do
  sleep(1)
  user = User.all.sample
  game = Game.all.sample
  start_date = Faker::Date.between(from: Date.today, to: 5.days.from_now)
  end_date = Faker::Date.between(from: 6.days.from_now, to: 30.days.from_now)
  if user != game.user
    booking = Booking.new(start_date: start_date, end_date: end_date)
    booking.user = user
    booking.game = game
    booking.save!
  end
end

puts "Import in database finished"
